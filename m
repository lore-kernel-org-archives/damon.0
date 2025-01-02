Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1F9610D
	for <damon@lists.linux.dev>; Thu,  2 Jan 2025 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735831340; cv=none; b=DkUKREB+J7o2EPMCfw8DULBnpPTNc+UiaEUCXLJucBV2HIucJpEfFN2UDHFN4IegMkEOM/qfCufJu9mcT5c0LNNTOBzy7eFC+MuK6F7q4N5MRv0Quic4SsHMSGKJr0v1Sww86c+Tv6KazXxhp7O/bwdCKKeLGQOwRJublchnxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735831340; c=relaxed/simple;
	bh=oCihSBuS2VNVO8/hWBLIs6K1jMBtk2K0UT43cb7VHg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXT3EkYn72xzmYMGg4XIU3aBH0QA+JUC1TSdYdw26gIbg8tejZEXr3A5aJx5WDEUp6fKkcganVKrzZe1LTwRewOt4PqPp8vsmRsKziCooDvIDcr7WY+KYjB6anRqPWMdcSpvBi1WAwOrFm6kf43mxADhLXirvOJu+YMaPprW0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JWKwdwmJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JWKwdwmJ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b9c6c2c44eso699188885a.1
        for <damon@lists.linux.dev>; Thu, 02 Jan 2025 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1735831338; x=1736436138; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7e6aFXIY2jI70eGDhTaDLuoI3uVplBD4j+gTnpi/Nqs=;
        b=JWKwdwmJYacAv/4zpD/ikuVlRCjwN1FV33lM5p1PLa/hdjiuUanfDC3zMdN6j/2r0u
         XHXZARRH3Zn3ckb5aPCAlQoJl2AaqWm9D/p8YgoxfsKVf0CZ9ZKeWOSOQSftGVbgSd7b
         HXPPMjZQT7bKHOxSUaGWla9MGa292/KCNwtDMayJ12A7MyuksjZ3L8sBHaZsn1BhH66t
         l0Ex97/cJguaFuQIMGOGGI11gAs8nEQUgAuiVIOGZAB6Z+PRg0r16ARTskDmtGXWayaX
         FcBEyUveByIFZ0b9M+6bvC2Xxoz0sKNx8chl9DVl7NAAkVGcffSZItLoFe7eqWF8X2Kb
         PwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735831338; x=1736436138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e6aFXIY2jI70eGDhTaDLuoI3uVplBD4j+gTnpi/Nqs=;
        b=nnmfQnHqXo6+y/XgoKtkG0Zii4pZ5q42Yn7Y1MCW6K+stIZuKsfw6tF1vWIgReRKq/
         sAQlhad8coyMdV0KbbMKLJWUOeUO/5BwmIphYeLYKI1UeGwShko18yEpQIiBktvZRsCw
         8S6TkRLR0Smy+n4BzuIsQV8AZZzvg7up3GLO4C1lIxJjlk1KC3qD4FbtK8QjV20yykiZ
         Mz5hySHHcfp5CGhqKpeBVAUYO7GLTfNZreZQs7s9I7FDgWZlDmoPvhWkd3WHxJfJj00x
         uHF7How/AI8z7ncRfqWTUGcSRBHgTDANI1dIFLcYbtsCC/0dP0+6QPcHklS70DtcozGo
         86bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjefj/3hRWhaWwC7Z/2edtoOUisTpzcUUlwC5PlBWgPzSff/A74ChF12DU4P64G2wb55tk2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIjylDai5QvqzoVNV1IHly6NaGEalApkdI2gQqQDgQnWp1T7E1
	8935mhy/eExJyUrlcuHsUZvvGsxYdrp6doHWisIF/vNQi9MVmlzeWLo9uw8DzD4=
X-Gm-Gg: ASbGncubrFn9FK9ewvwQD95BXMh6GeNrdUdwvO/Y3U5PDfRtCDO2wdBNeKvOgzWViMz
	+5jqHnVFLdTCJ7ugryuqLXzZOqPTyjjJmw9wFULT4Wys9GUswulonKifDa2QBxEVD6KnIizHf2x
	yS8h3reh7l3w3K+lhwLCbyUTMk6s5eUm2470yzxbMt8ocepJxzmmbm6XKCXQnVCSDPGzZ4lVxw3
	7hkwYOGKzBl0avlkgEexO7eH85rx2BL88c2UlCmEYp4V8vOT/FvTYtI0ARV9VQuI5xZ8BOuLoXX
	y7JAn3Y+Y//Y7LILPFi9kD3JaOvVXxXKS8bARS0=
X-Google-Smtp-Source: AGHT+IFJi5ZHDBoES+yY082aj6WOBTVnLviKXgAJ2IMoxXIAcz/heNto3P5anrtdmaw1Pg9lmvXJNw==
X-Received: by 2002:a05:620a:4486:b0:7b6:eed4:694c with SMTP id af79cd13be357-7b9ba84f893mr7754038885a.62.1735831337980;
        Thu, 02 Jan 2025 07:22:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bbd1dsm1193273785a.18.2025.01.02.07.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 07:22:17 -0800 (PST)
Date: Thu, 2 Jan 2025 10:22:14 -0500
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>, lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Raghavendra K T <raghavendra.kt@amd.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>, Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of
 Future
Message-ID: <Z3avJl1AJYG96RAA@gourry-fedora-PF4VCD3F>
References: <20250101222039.74565-1-sj@kernel.org>
 <Z3YRggwxMQTxfQ4k@casper.infradead.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3YRggwxMQTxfQ4k@casper.infradead.org>

On Thu, Jan 02, 2025 at 04:09:38AM +0000, Matthew Wilcox wrote:
> On Wed, Jan 01, 2025 at 02:20:39PM -0800, SeongJae Park wrote:
> > Hi all,
> > 
> > 
> > I find a few interesting and promising projects that aim to do efficient access
> > pattern-aware memory management of near future, including below (alphabetically
> > sorted).
> > 
> > - CXL hotness monitoring unit
> >   (https://lore.kernel.org/20241121101845.1815660-1-Jonathan.Cameron@huawei.com)
> > - Memory tiering fainess by per-cgroup control of promotion and demotion
> >   (https://lore.kernel.org/20241108190152.3587484-1-kaiyang2@cs.cmu.edu)
> > - Promotion of unmapped page cache folios
> >   (https://lore.kernel.org/20241210213744.2968-1-gourry@gourry.net)
> 
> I'm not sure how DAMON can help with this one.  As I understand DAMON,
> it monitors accesses to user addresses.  This patchset is trying to solve
> the problem for file pages which aren't mapped to userspace at all.
> ie only accessed through read() and write().

DAMON can monitor physical addresses to, though the mechanism is
different.  I haven't assessed this as a solution, yet.

~Gregory
