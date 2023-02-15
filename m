Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44DD2E1
	for <damon@lists.linux.dev>; Wed, 15 Feb 2023 20:21:52 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id c1so21762172edt.4
        for <damon@lists.linux.dev>; Wed, 15 Feb 2023 12:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PGQ2Tjph2raaiJJrHEWHFU5AYzV1uv01WttFdbl8X1E=;
        b=V4bh0Fv36Oc96JTrtwDRSTpRRhi4LZ/kX4qEbvP6JqRfZk1/DM5jUVx5Kyj39yoIhi
         aq33fcQOTI5PPoku2ND7mukiujbjW4a1bQG4ZzuMpv6Onpj3W8XzL9y6VaGZ/XlDqAxd
         MWIEni88bTVGzfFSjBMo33x9Bj5G7hovJOQRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGQ2Tjph2raaiJJrHEWHFU5AYzV1uv01WttFdbl8X1E=;
        b=6cZPN8bI3VSBkl+wTQ9vGyiTbor1pIDEzsIYCiwZ1Cj05M4sJo/DjNvngtX70eLzVQ
         yhVndg2F8uoHlpq5OOnTIWH8Pl8W4rFmx9aLx61LYKS8IdmrpnnSqKK94fX2/ujtPdMr
         r17uCctJLSsT9CpKim8lr07jwwx7fM19bjMD3dl8FssuFrycqMnJA8iEelvR7ZuLwRl5
         O3rtrrlJtI8nEDcMyvQPuljMqEJVoVjLF5X0tQPsRzo5MU3Wy/KRADIJa1D0mLDrL4K+
         i04xKVL6I4GUb8i35B4U1+99i5sES/cypVjkfDAMUJCFY1mT28WvkJUWQ+55RMkLT47T
         SkwA==
X-Gm-Message-State: AO0yUKUYx2fNSMu3RnoCU46fd17/oTrn5M0cNtb6br1G7SD/1hcoZ4U9
	aDXVbG1KuV/r5hiW561Xi/BHIubr3FbQzc1yEys=
X-Google-Smtp-Source: AK7set+y9jBJupDib0SR39FtQRMSDXK8Wj5fdQX9w2f8AUxh8iqHfECmeucrOAJh+0H4ZUzsx0fwDg==
X-Received: by 2002:a17:907:7657:b0:86f:e30c:72c1 with SMTP id kj23-20020a170907765700b0086fe30c72c1mr3897503ejc.8.1676492510934;
        Wed, 15 Feb 2023 12:21:50 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id dx12-20020a170906a84c00b008b128106fc7sm3141112ejb.46.2023.02.15.12.21.50
        for <damon@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:21:50 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id a10so25536221edu.9
        for <damon@lists.linux.dev>; Wed, 15 Feb 2023 12:21:50 -0800 (PST)
X-Received: by 2002:a50:bb2f:0:b0:4ac:c720:207c with SMTP id
 y44-20020a50bb2f000000b004acc720207cmr1826668ede.5.1676492084676; Wed, 15 Feb
 2023 12:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Feb 2023 12:14:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjG+MD3JBJ1qN8tD_di9K+kV0_PSe+DE9MRGd8Vco9CNA@mail.gmail.com>
Message-ID: <CAHk-=wjG+MD3JBJ1qN8tD_di9K+kV0_PSe+DE9MRGd8Vco9CNA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Change the return value for page isolation functions
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com, 
	muchun.song@linux.dev, naoya.horiguchi@nec.com, linmiaohe@huawei.com, 
	david@redhat.com, osalvador@suse.de, mike.kravetz@oracle.com, 
	willy@infradead.org, damon@lists.linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This v3 series looks like it's making things more readable, so ack as
far as I'm concerned.

But it looks like it's firmly in the "Andrew's mm tree" category, so
I'll leave it up to him to decide.

                   Linus
