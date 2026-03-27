Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A973F99F7
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774623394; cv=none; b=Kj5peabC+GMQ7NgBlI78Nid40PmmKa5o362HZ+TCIkAf/EwE9unRPLbE8QsSTOyPp/MgWlZ+nH3RIDvBHnCUF3rDsRPuyo8qGrU0w3iWP//RcGs7K8jrH3YT1YAwZ1FuZatG6a+PRCX4rzyDdXcD2HGcykYIxYdIq7B7QZ6CrJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774623394; c=relaxed/simple;
	bh=yyWfm0ySkiCeRwYqW3pFdGsK0cho74a+bj03NxnAHK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdVDI96/2O3KXukcZy3+qTCmq0OLt1aHmbpXnWXmr0p9P9wJyDNnRJPeSb8+MsYG2VxAtPJwo3LWxCXldBq5vxMjyU2AoCYuZFFGZCpp1EoSKt2s3P5WLVw2Otbbrv5myFyBuiMEakgb5GJ0HMgEYm/AY51WZLANc+UVtcdQ+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAY3DRmu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAY3DRmu"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c6e2355739dso951421a12.2
        for <damon@lists.linux.dev>; Fri, 27 Mar 2026 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774623391; x=1775228191; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uHKUylf8tYMP1/PZy5NB6UDbuv5S6RUBHBilQ5ozM4=;
        b=MAY3DRmu8oh2bBzXeu9DHaoFnTsKl0RU6ZQfnAFRohkhIlebjR8DaYMCB+7d0IQg04
         0RI2lsjRUzQc46bPuVdcCQalnYt5iLuKcxyNQePSa2zn0aN++cvzKY0ki4o7MdkMCJ1H
         ie0KKGIMisAOs+HgTIr8jDM+ucbans8NFwkndR+4xWXJC4iEhgJsvHMZjSmZRItRqPbr
         yxnA0QWIxMIPv0PXyQvlbnOKoXKwsqIorewzhEPJcBn/hkfEjihPVhpDl8dTvOBP/ch7
         N4iyd3ZzNPYjPpp4J2AniXYdLgF41Wi74NGkDya4A1n02shw8cSG2PpvxuyvdVEXW5bX
         817Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774623391; x=1775228191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1uHKUylf8tYMP1/PZy5NB6UDbuv5S6RUBHBilQ5ozM4=;
        b=b6GOuCeHsbcvMF8yUS3DgyrhE/ZTJGIwg4oWBJ2QceoQf+wukBaCqkagBQPEsTHfUq
         OyWgprs6K069651+HvLoV++LGN82e9Yvi9qNymvGaNgfP2jDTpKi5cPfOWUgFCrz4i6H
         /c9I0sDiU+gioVvD9v7p49JgJ3ridlARYYbBMRGdT5fnJwml95q90usH0RR9fqkAszKL
         jh/QJXgLLFdmnQT1giTSzdd+7ju3iFBvziZ+Im4XfzmXzkMklx1nxI9pJv+CB22h5YDg
         1UsbspqjgLGw8qXNp+g5B73didjHAVm4bawjd3MNd4pGwnOzml9ThmQzF7iBiGzbIxR2
         ZOnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzXtb66p/Ay9e4c4kzguNzxTXIj0KZPi8IITjftHoqG+pe+x1DKIsiK6LUJ7g9PUqeqfOSpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUuXU1DeGZRq06Uohtn7ev0q3ya9QKEy5zDBa0dLAS0PtKIwAu
	Lp85cGE/d2EY2eJJKsdXuylHPrBV91Kh7G/3ZRJTJkwLU4JSvuf8gcei
X-Gm-Gg: ATEYQzxkcCUHYj+KR1dSOA+6p4ncB1ez4hge6eDWffIoMPtV0Q0Mf+9y0mebZf9AvD+
	NWylcJwWsE+P+QFCN598eErP1Z/bgs8XGcmnLpYFULaCzuyNTFAygRN5l53Fj03LwBPW1SScXRL
	wYi5tUYBHQRch7lPLby5RLOwQHvKgi0kxvBOb7ce7lh94E2uR97Y2LL5VakT43GUo99KO84DT7b
	pWVWPoPjyMxi9ibICU6eqSKptWHwVPxLTItC2Oilcqve32hVtk/iyRz4Yjk1hrQ7886cWTGbirn
	t2DW1ZmiTBsy74LZOz67sBxYortz8wwvHllqMOD0FJBp5yq0Cv6E8dgiDD0lODjcNw36R617gRN
	WsQeDOT/Q08pN18RMU0FfRaT5OjaylTmjbCaBbVcFJYjicO+NPGPxZ6nrTLZ0ynXzuA2XAtuGxE
	Rn61H6Ko0WHVgKzNerPhI2Zn7DhHrDr6/l8EMXqg/q5zGJCWZj1Y4=
X-Received: by 2002:a17:90b:4a8a:b0:356:35a5:4a64 with SMTP id 98e67ed59e1d1-35c2ff1e0f2mr2817674a91.4.1774623390988;
        Fri, 27 Mar 2026 07:56:30 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22db12f7sm5156025a91.13.2026.03.27.07.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:56:30 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Fri, 27 Mar 2026 22:56:27 +0800
Message-ID: <20260327145627.10419-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327141450.4345-1-sj@kernel.org>
References: <20260327141450.4345-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

Thank you for the detailed explaination and for pointing out the
'PAGE_SIZE' limitation. You are right; and I should have accounted for
that.

However, I performend further testing to address your confusion
regarding kdamond's termination. My patch didn't fix anything.

Here is my reproduction:

# Log (Both with and without this patch):

	# cd /sys/module/damon_lru_sort/parameters/
	# echo Y > enabled 
	# echo 3 > addr_unit 
	# ps aux | rg "[k]damond"
	root    71  0.0 0.0 0   0   ?   I   22:26   0:00 [kdamond.0]
	# echo Y > commit_inputs 
	bash: echo: write error: Invalid argument
	# cat kdamond_pid 
	71
	# ps aux | rg "[k]damond"
	# ... kdamond terminated

I am very sorry for the noise caused by my misunderstanding of the
sashiko review.

The real question I am facing now is:
Should kdamond terminate itself when damon_commit_ctx() fails due to
invalid user inputs?

Best regards,
Rui Yan
