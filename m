Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029945;
	b=GjV1Hpg5sudtUqDLmQXAGXyDZeUCv+N7hGFdfOrKd+MiEeggWXAZoignX7Z3RmS467XM
	 uZsDZxONicrn/pB0id8qo9DUKcguLXhevE+ZF3TBCHZ8BmC5OPtX+WQn0lMfNJcQGiyMJ
	 UAuASzMC2c2B5AeFNI58DHay6aJjjx6OZ0WsgW6Xb226rBvrpoqH7oX/70lRmSKFUdxdd
	 hItN8895xn0akYT/uEnTPbhDvpMxzZZ+IbFYr5IxFPtrvBJ4bEonofPY69EjT7sUWNbgZ
	 /HfI7z0aCir+CkbvYn5RrAQAqpEL4Qh4nDNQS+2u0nny5w2dmdeJNQ9JkfN/b5SFBqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:Date:Message-ID;
	bh=VaQMEbNe6iILjWkN+oLQ9JFAOPWDJQN9tfc/T2bNOlo=;
	b=wm/vtECauUAB5iTi6fVe5tV4rXuKA+n/Y6zGrmb4yNwYwY1s65ryq/5IWJCDk8HnyvJe
	 7w2YLUanfGb9E9sfMSvaRwMP5YeSK2s5nAJlcSo9jwU1myqYGSK7KWFMhZNuKRCO8nc7Z
	 8o3nVCr8GYWV3Jk3f1Z2opOQ3RqaJANLW3ba1R585Auox85C79mv3nCLlVeis6EEYh8Aw
	 uesa4jHQR820TClp8OOkCwOz3/4OONCs2C6x09gZaqGgn95y6AvRWD/3/TldPnnZQQx0C
	 c3Cdgz49GalwT3woeobmlQ3njuOqwZil/PYsAmZR8aY96h85ygVBs+tAv57wu2igfYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KHm9OB4j;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21E606A324
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 15:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B21E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KHm9OB4j
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-3ae1dca6bc0so736929a91.1
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793029944; x=1793634744; darn=lists.linux.dev;
        h=message-id:date:mime-version:content-transfer-encoding:content-type
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VaQMEbNe6iILjWkN+oLQ9JFAOPWDJQN9tfc/T2bNOlo=;
        b=KHm9OB4jEsyS0T9Mgv3HaIAuzfPTSiUpPE3ZGkd0BT+d8TO+1/tq7a2jZtwVdE9oHX
         /2O/nbl3vBxHZqRTlcIyxbupToSwLwW77YYGMH22NtOqaanAlGLuEue3XqRJCKywBwFw
         dWBzFlfKYaz2qU4YzdxbjSyqCyG+KGisWZEPAqMkyLb5iqLIt5yvKgE4EYFj/PE6Bgcz
         kkl5SkmL204vtqxDwJogD+18pAEOtJffzqaljC3WRdBtZMe6/+hk3GxSShIG21Ogj/+c
         hZOi5VSOzZETRVK2GsborE9MoSk4gU3Ih8Udr998N/Opqm3naOJVAq9dx646ltz88zID
         z4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029944; x=1793634744;
        h=message-id:date:mime-version:content-transfer-encoding:content-type
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VaQMEbNe6iILjWkN+oLQ9JFAOPWDJQN9tfc/T2bNOlo=;
        b=T6rpWogy3Xj0hNFGIJAjMC5CLaC0ym+7EA7utyVrrWx6oF2H/mNMAeUxRl4kqA3kNg
         qh4rJ+N0VsIDsKwEGHmjy1MGE5SdDz/Ug7PhJsWHBl2CSeTraE5E4BHntCHKBP/zgGJl
         TlkSYZ4lG2BNoaaGyKNnjs9xnTm+BHECHPYTGHiiRsFq1+OyvGmR4s5Zy6g77QxWQaeW
         P6ntSGDwBvP6VZpDnqwFsDNSbg+8hFmdVgKJxj8cVRfEG7Vlm5e2dz+pOvgeKYw2I6hS
         J5G8FV3eB0pGG2tvEGSAuaOWjj8FaSwS45q5zyXUm9BcHG7N8j6qbzvdXQXN9GZpZ/H1
         RGqw==
X-Forwarded-Encrypted: i=1; AKwUvBwecdvknnK8GEal9tA9yGmDMeaJx+Wclm+hLMDk72O5xqJarnFLdXxjazNHcNvN6Z1vE9mhVQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIfraS9jioTslWGx7HY2bUY4ZaVG5RKcs+D7xjb41XHmxl1SEPT
	uKLqQnDiW3Uk8I81EiZk4Wdyr8jAdtrn5SSFKma8FRFjQVvx/qTTerL8
X-Gm-Gg: AYBFou3F/P/Fz0tluatIx806SAMjPGrFFPrD/+kjqJTooYznZf8m/B9eJpsIFMxUtsc
	r5w6Ou++cDXSdK4t5RHDtRLKFKmFYqBl38cvFqldomQRt+tkBE/WOgBB0nAqGYlncxSyX6e4dvD
	vhObpETliWcQZ0x8Q26PM0/HN1/mNyEZmvHlhmp9SNXeh/geeSp1cvL/cLAUHC34lXpbZMt5w5X
	GdUdQ9l956uiaINNnlS0eHKmxn5rVlGLNnqaS6PVx/FUDZJVNBObLZgAsFubIlyMMh3zz9BYddN
	c7GN9jnzKAU/UGmTmJ0EFdtk8jfqXIQAO9vBY5FuGY25t7nHtLIPkSmL1rGsY0x7ZM3M5+H+Evw
	vVXFyai7cZ1afQI2jswciqfylcsOdJFyLNGKkaPk//RvO2AabFilkdbXAnyNRqF+N5IbryTOmha
	mWg4KJ/yVQ73ZdBPEGUUkjSCwtpp0kgs4UFn8bnMcPdF0EWoCE7l+m4X1cY988njTfrMy9dYKLQ
	Pw2zD1pUoM/ReFza0kNOF4pmH1CwS11dbQwQQcKaWN/18BPA42dHWW3440rqOFh4z2KIBwgKbAi
	3c2dnGMPExZgETDsWfwXgRGiA2Zxo7YSPUEYk1GBkQ6xVZfB3LNtvA==
X-Received: by 2002:a17:90b:55ce:b0:3a8:185:cf40 with SMTP id 98e67ed59e1d1-3adead57ccdmr6255798a91.10.1793029943804;
        Mon, 26 Oct 2026 08:52:23 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40427782sm48676a91.4.2026.10.26.08.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:52:23 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] Docs/admin-guide/mm/damon/start: fix grammar
In-Reply-To: <20261026142927.149910-1-sj@kernel.org>
References: <b0d8d0ceda82e303262c0f61324fe8a84fd9f745.camel@mailbox.org>
 <20261026142927.149910-1-sj@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Tue, 27 Oct 2026 02:50:54 +1100
Message-ID: <179302985413.2.2084375678408090049.damon-docs-reply-01-start@gmail.com>

Hi SJ and Manuel,

On Mon, 26 Oct 2026 07:29:26 -0700, SJ Park wrote:

> My intention was saying DAMO is commanding DAMON to monitor the process.
> So I find Aveline's version is slightly better.

Agreed. Both "start" and "make" depend on "asks DAMO to", so I'd keep
"make" here.

> Looks good.  Unless Aveline objects or do this by themselves with
> revisioning, I will add this change when I apply this patch to
> damon/next.

Those two fixes look good to me too. Please include them when
applying, SJ. Thank you both for reviewing.

Thanks,
Aveline Noir
