Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767AE3C1D
	for <damon@lists.linux.dev>; Fri, 28 Apr 2023 14:17:06 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2a7af0cb2e6so97778311fa.0
        for <damon@lists.linux.dev>; Fri, 28 Apr 2023 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682691424; x=1685283424;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pX9WjjkTv92gewoGzLGlJ8qlhFBP8gtOO2O4fVnFTWY=;
        b=mXbK5ex0BXyMpLjDWNU7TKeDfTqZAPDifoOqG+/QTXcKYcQQ6AsMPVxDbED6qa9Ljh
         F6L0+UWSIa5oRlX8fdarniu5z+ghx7gmeYSlG+CwwkGQsrz5y4pZnVkNBbyr2byI4WeR
         vURocvp/agpqkZQdjcD8yYZlPmUcG/DI5jKWTFKEzXhEvCFspSFWdj/ov+IYqxFVHl5/
         TxIswOh5RPmfp3Cjz3SYOvmQshcssdE4gQAfxdvkitCiofIUzOSLPuHvAZiFD5/UCZSA
         VvAgc3u3Gqxxh3fcxnlpOGwZe20Gis1p+xMlrBbtRsTE9q7XhpWa5i6HERR+AqFo57QX
         E/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682691424; x=1685283424;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pX9WjjkTv92gewoGzLGlJ8qlhFBP8gtOO2O4fVnFTWY=;
        b=U9tafsV8sdV6ZwQdPGZ0y9XuOzBydp7dN2ZrGXP7H/SJmAb8CIxnbiw3buBzzZb03L
         CwCD2B+JLo9zHR+4u06HQEupCWUkuj19m1b8NdvZUTDAf4vvdzBuPcwdwbmFGw/P4Zx9
         3OfZiM0f92/xRCr+t87T3XheuzHnvAkxczybYxy9BdvNIdP6S94M9Wlzfn/eYwCDrfXv
         bzCKHz1TCWfizDUSBlvvEKatrULXw5LA7Rt+uEvMIqtqJjgoK8MyWnSSsfUMQln63hR2
         jAjJLZpemiz/9ytoCvo/AOiw/D2Ku5ydbAYqnuCUkVddpzzyFJa7LIpfZez6Uk/DCRbL
         ydfQ==
X-Gm-Message-State: AC+VfDxKR6cUt55OQ1WJrkKC3OGXPmQNh5gVojouWm3poBNjxtDmblzc
	YPN1jen2bd7WAm2X8eRcSpTN0/L/mBI=
X-Google-Smtp-Source: ACHHUZ6USqaqZyrOcbbOcvRmFXxvcpU7l06vpYuEcE7e8EVpOTP978+Y0yFcw+ymcB1ZRH//sY0lhg==
X-Received: by 2002:a2e:8895:0:b0:2a7:78c3:a3ee with SMTP id k21-20020a2e8895000000b002a778c3a3eemr1506548lji.45.1682691423853;
        Fri, 28 Apr 2023 07:17:03 -0700 (PDT)
Received: from [192.168.88.92] (95-158-68-28.static.chello.pl. [95.158.68.28])
        by smtp.gmail.com with ESMTPSA id o8-20020a2e9b48000000b002a9b01bb0a3sm3379799ljj.57.2023.04.28.07.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 07:17:03 -0700 (PDT)
Message-ID: <c3086fc3-f33c-4eb5-db1e-9dec731aeede@gmail.com>
Date: Fri, 28 Apr 2023 16:15:12 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To: damon@lists.linux.dev
Cc: dutkahugo@gmail.com
From: Grzegorz Uriasz <gorbak25@gmail.com>
Subject: What kind of memory is DAMON RECLAIM able to free?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I'm running some experiments using DAMON RECLAIM on the 6.2 kernel. I've 
set up an VM with free page reporting enabled with 16 vcores and 16GB of 
ram with very aggressive memory reclamation settings, my kernel boot 
line includes:
- transparent_hugepage=never
- page_reporting.page_reporting_order=0
- damon_reclaim.enabled=Y
- damon_reclaim.min_age=10000000
- damon_reclaim.wmarks_low=0
- damon_reclaim.wmarks_mid=999
- damon_reclaim.wmarks_high=1000
- damon_reclaim.quota_sz=1073741824
- damon_reclaim.quota_reset_interval_ms=1000

The memory usage of the VM starts at 800 MB, after running some 
workloads and ballooning the VM to 16 GB DAMON RECLAIM was able to 
quickly bring the memory usage back down to 3GB, after which it just 
stopped doing anything. What concerns me is that 20%(3.2GB for that VM) 
is the default low watermark in the DAMON RECLAIM module. I've verified 
that the watermarks were properly set in sysfs to my custom values, but 
it doesn't seem to affect anything as free -mh shows 400Mb for apps but 
2.6GB for caches/buffers. The VM besides idling for a very long time 
isn't able to free the buffers. When dropping the caches manually using 
/proc/sys/vm/drop_caches the memory usage returns back to the starting 
one. The cache/buffers don't increase at all after dropping them 
indicating that this memory was indeed idling.

My questions:
1. Are there types of freeable memory which DAMON is not allowed to touch?
2. What prevents DAMON from getting back the memory?
2. /sys/kernel/debug/damon/* seems separate from DAMON RECLAIM, 
/sys/module/damon_reclaim/parameters/kdamond_pid shows DAMON RECLAIM is 
running but the DAMON debugfs doesn't show it nor exposes any registered 
reclamation schemes.

Best Regards,
Grzegorz Uriasz

