Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882045;
	b=gXPHDWF+j7IZjP2Y8WIkeWlFs7qKBSFNEtnA2CJGs/TJUptxy6iiKTL0uOqCE9aOjEUi
	 tlwJK8th+gY/AlTLv7Tn3uXyegcdl1E3fASppe0rSFvUW9dXTNvn3Wk+WDoDQ6pTVRw7F
	 QvuuZPs1/yvWWF/csSfZ7Nt9FDWgKlto8MU87+rtfLbVWKoJSvh8dbxyuEgMMDGRN4HQq
	 4LPL4TsOJyhNtlZvARTdJHqsdRAjo4Wkt54E5l44PdFQV0aZvVaAkZrpvsnZwLaobqQu3
	 xB8Tk0MmY0dKPT7esXLkZM0VmuUM/Ne1SH5S1xHhvzFGw6XTIHNUtTU7PH9/hR6egtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=xnbdQF+mYCE0wEkhXTSh32IAVnsikEgxzBr/xzLSIyY=;
	b=pl2qxC4GYDH09zzsFCEXMp5N0RPyOMQHRa+EmAKYVqzFDdJBkSHIkUObMmh1Ww3I44dn
	 jjgVj+/MKPMUqDZXd9eypfqiFQb372LTHKE11WfDpQWWkKegcqjLCVyLZimaN36OIp2dk
	 6P+Jzl6nuseGEiqWxCRrttd9ymmXbXi8LQ0OvuGfWy0vKD/VmWWU0pYfUIHwRpxfamKV2
	 05tiSan9PtQAV3iJVLbeGlWqD7QRknyoiUggV/ryJ6BdBF4wX3NOc5wzalWWfe5cJiuCA
	 Fb3vUpKqn9F72AiL5fwscAOmjLl4UKHlHrcfyzFzy8Dvw22+AaKAus3isTpDcQG4GFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dE2zMQ8o;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52464606A31B
	for <damon@lists.linux.dev>; Thu,  5 Nov 2026 12:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52464606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dE2zMQ8o
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e97ddaf3c4so7404715ad.1
        for <damon@lists.linux.dev>; Thu, 05 Nov 2026 04:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793882044; x=1794486844; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xnbdQF+mYCE0wEkhXTSh32IAVnsikEgxzBr/xzLSIyY=;
        b=dE2zMQ8oBh2t/AFFL1rbIbyKHxbh3QLorXmWhv3yvB1DaQ2d2/1gZMbJikEqsDOVWO
         REU9tXeXzwI+pIjSa/haAQ07NuTFhrpqjn/xZ1i4PIcyiLe/V7fsJvIyW/a0UJaVE7OF
         ZYe6n42X+9ztx2l/Oks1CQkTT04uQDxnSim5P4aVMl3AyWTB7SZExpK8Mw6yTjzRIall
         RufUSAmAcknXoAuY2Vn63NjdKWwYj3BUQ+FF0YjqDoo+xx+SkXzq1vgeFAa2NZZt/KX2
         tS4cKaFy+KDeGxf/AXP2aLT1gtwBMr5vLJfoyomWytUqfltCFH5sRcGJ0sHHlExe5BJa
         uUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793882044; x=1794486844;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnbdQF+mYCE0wEkhXTSh32IAVnsikEgxzBr/xzLSIyY=;
        b=AzF1yAdf8YWuorTkb8unHSFk8AnxlmumS1YQMzryC6fZ+ynXGeV9a5o+2Qf2N8kREG
         IoozwNwV+6fXV20tcbOzTAqP4iue6nU25Ph19WTKXOpg1zuL7HkbXL6tyPx8Du5hTmBm
         enCJUGRPoM2pwmp/fll4wBcM3we6qz/frD9Os49IEFgusciIQPUJlhW7EPB84h+QEtQL
         8CCTZ9K/dY6vcFS8PTWtJGGz0MDmjXN9wCULt0228KqfzvuvGnBF0QRIXZP89APOZ5uQ
         e3o/W0BsmeI6k/p8fAprcPXaJLJL7M5X3jyzOMp50MFyodxQlxOb5A9opW+K7D2+OxpT
         9ZSg==
X-Forwarded-Encrypted: i=1; AKwUvBzjJIJYwA1qebwS8dPFkWoUNIMgsJmKrYanBYpuj3fjResF2UyFA/Y5qkAxhXAidwoFMh5Lwg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/9x+XOG2MeypjkqBrer2xdM+9zX0defWzaEpDajcGMWEQ/tWEb
	3rIevphMjgvMq8mv/0e/CYN3seq+OKJ2AeueP0/27SSGKlxQqwn5XXM0
X-Gm-Gg: AYBFou1LOVWgvm/fH4Hx72JbtW7w4rQaMUBR6s7dRz+9GkcQD9NohAXLXI+yc6pXpB+
	bM1ais3eLMhqkrHuxYLyJSXs57L1mEvuWOpWD7H44c4prKjMYQ97YGW1ji/AqLSgGOY0ARqXK4B
	0s8H2yZvwFL8ucN+furwnlYffBbA1w13U7UiKdR+tfO+0S3sk7Yce8vJLq+DWPLL+c217hwKxbs
	SslU7wqiS3MHqmMPDw6T92eam4ttdZGRZDXZ67ieJ4EO+9uFzgk/sL7nGDjgsy0c7QnTy152xeu
	XxUKknzWLLypxp3EUn2xgsE8JijPSq6M+rKJidCckMCtTfjjqZJyln3U2IPSmniGg+DFbjlJKP0
	SyqdRJZ8QtMwbZkNnphk1b2lP+9XLFAEume077wJEn7FUZeH88WlXxZJODWppyMSxKujUO4oBcK
	iD9xDe8Bs8s0ha1vhbWbWJqJbRP1rqE/J7JQcZPHB9vRKP27IE3qMVEYWy68cRUodEvcL/QehL+
	T5PGDjz8ikkU3QmziahglO3vgRZcmY/pfg0e25kt13ltrLsb56hbJp0Nku5RMAVAApgtRpi+eTA
	KocnWNX/V79+0FLT1JM+DquVqLeNKgJTg6PREEO+QIUFVPNrM/5+5PM8RM+hewX/X0DBIpdL7d5
	CzXZJ6NoTNpfRTqjDUyK7g8X1jms=
X-Received: by 2002:a17:903:3910:b0:2e9:3dd2:a904 with SMTP id d9443c01a7336-2eb3648b6aemr182844655ad.16.1793882043510;
        Thu, 05 Nov 2026 04:34:03 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08fe55bdsm17043995ad.15.2026.11.05.04.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:34:03 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v2 0/4] mm/damon: introduce age_ms damos core
 filter type
From: Aveline Noir <jm5905938@gmail.com>
Date: Thu, 05 Nov 2026 23:31:53 +1100
Message-Id: <179388191315.401969.13923237674993632654.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Randy Dunlap <rdunlap@infradead.org>, sashiko-bot@kernel.org, 
 sashiko-reviews@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261105044425.87142-1-sj@kernel.org>
References: <20261105044425.87142-1-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Wed, 04 Nov 2026 20:44:20 -0800 SJ Park wrote:

> One straightforward solution is extending the DAMOS access pattern for
> specific deterministic time based age specification.  However, DAMOS
> core filter is a better option.  It is playing a similar role in a more
> flexible way.

Makes sense.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
