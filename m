Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0B2D5C76
	for <damon@lists.linux.dev>; Tue, 12 Aug 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021317; cv=none; b=o9iR6tfy0eKyo1OdJoBJUZtFIcLwhk0Yp9YTOfFm2DWPgGBaDsfOK1idTnwpLUEXk4ZZSt8afGyakqna1gKp2DPJJjTki8XX8zmAXP5/WUGmIigV9VM+quBZEk83I7TkXHggFo+rdesMFrCvgmDrztNWBxcifxK3MQ5PSRvfdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021317; c=relaxed/simple;
	bh=PQ92Ps1KLUdy3bH+AaO3wSg7T74mkl3PFwFmSqQ51gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv/RgAt248ieoBcXEcNwN7peIwbPOL0aOWOZPrxJEA7J2ovAoIIFtvrEw+Qa+ugaqVjqpxCpNnj3hxZMHB1ZtPOeQaCZ+/gN24AJ3WFOISFbTrS2XyIFkXzpVC9xH3Qs3KgubWG9lxNglWU6oWOjpBkNQg4WcSqmeWHQHpJTpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqFa7gAR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqFa7gAR"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2403df11a2aso39023585ad.0
        for <damon@lists.linux.dev>; Tue, 12 Aug 2025 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755021316; x=1755626116; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymZGpmngRJ7fOyPoIYIbr864BuGgQbxABMyIAp/lv7M=;
        b=eqFa7gAR5mEaYRgYOgGk95hHI1D+JhLUUgDzykPEAhPqOmjc1YYYah9Sb6PBzQ58x8
         BmL7gEr3KPvn4MOrDsWeD00t1Wq+VuLDNHjahXWxcGtSGOFiCPoq8SCepLTXMxiLX8Ro
         WNp2m6v8y+oMBrIqwJeAR+pix3c86+vf2sp1FwB5WZFyUj8S0i3OChpqOnN6L4t0KDNd
         iuYS/8qxuygHaEujEpC3hztZc+1fHqZ4pc9RzxdSrdL1Um0eMA+G/FYGojp78HcJY/2l
         jLzX+pX4SjSVR/2jQV06m/9yLk+KGW8bYt0CIYy5J0Sdpwp2Qs4GO/Jih/KjmhT9STDK
         S8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021316; x=1755626116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymZGpmngRJ7fOyPoIYIbr864BuGgQbxABMyIAp/lv7M=;
        b=thSQvixefZ+O1sc49cP/W2tlSdzn/1MsFA14gr6h18Mhjl4YydhpAJjn+jniQgNtjo
         Kw4c0hAaTI8aP8+LNl6jTvpmC0/6HkeConvHguOincYwl5KmwRbilFBiexqNQuSP88LH
         TE2kvkScjQlAzhGaKBuGMAsGiXokPL/mlyUiGF7PZqYOzM3Zxn+GbIuMBSyjCabNEyKH
         gQDY4SS0gMNr/i+vGSvRDjPzsOVVAnW2oaAuhCa5HoQD4qCT1xMzAmH/27G+vHfeSPDG
         rq2HKsMjbHEvO9R9JMTYj1iLlOxwluTtfxzE6yOC0xu6jEUXb4ecxg/IlGJwBhnFZOCu
         QQew==
X-Forwarded-Encrypted: i=1; AJvYcCXGPPw39aA88wUYaoNE3oMOaXlPfdjNJ3A0hMHPdoffucmEk0i0d7S7V71KlmrvxGvUGL0ZXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCDCtOWXJjb5EZ8AzhUTGtpURqJQn/fhyiqVQeYmIMDHT0cmE9
	t7z0o/wgzlU3uE1uIOq3vJsNKHcPI1bgBa0IE65ZMROiScRQdHro3PPs
X-Gm-Gg: ASbGnct0OEBfvWlPsvgqpVpTnf8q5V0bH3K6JAoyVa50dMAOPBZQsm8pXvUM7YvanJK
	ht0H+t0b1IM3H7I1CzJ7a9i6C4Y7z8RygO2ZZ3R36Cx4NzesJgAHHhlbhfyJ/JdnzBqQczm3/ZP
	gyEilHrAvE4tkAHPAZK+LKyui0Kh55NZ4Deb/dWFGDx04y3Eo7dRIG5e0M3wSZEzbYnx8Yp8N5o
	aD3sFmkqmsxAprKoHEt2EWB6Ssye5uTRZ+idM3MMFWJ6P5uMIWN0dHVP/yQ9kwEbsnWF5F1+ooy
	i4LFLEvNSmH1/ZNHQMPpoGVNGx4bmg3b1lYx0GRPLv3NEU+PAV2TgKRitT/M/HPw8dhuDlaSkKW
	UN4fNylhzO3xfIqIW0U/5J4ze1uR2+NHt3qkJZFl52qMX8l25DZdMCyRrbkvTCIiF
X-Google-Smtp-Source: AGHT+IE18aIbwR3kUmI00of6zx1vDAbhjJri7AMTb1JJykSzC0p6KytmOlYDyZhwco9kF97wduWaUA==
X-Received: by 2002:a17:903:2a8d:b0:243:8f:6db5 with SMTP id d9443c01a7336-2430d0a260amr1715145ad.6.1755021315592;
        Tue, 12 Aug 2025 10:55:15 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2422ba1e09csm279039935ad.16.2025.08.12.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:55:15 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:55:11 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Qianfeng Rong <rongqianfeng@vivo.com>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mm: remove redundant __GFP_NOWARN
Message-ID: <aJt__zOHjGcaghNf@fedora>
References: <20250812135225.274316-1-rongqianfeng@vivo.com>
 <b5ca3ef2-bd36-4cb5-a733-a5d4f1fb32fa@lucifer.local>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ca3ef2-bd36-4cb5-a733-a5d4f1fb32fa@lucifer.local>

On Tue, Aug 12, 2025 at 05:46:47PM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 12, 2025 at 09:52:25PM +0800, Qianfeng Rong wrote:
> > Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> > GFP_NOWAIT implicitly include __GFP_NOWARN.
> >
> > Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> > `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> > redundant flags across subsystems.
> >
> > No functional changes.
> >
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> 
> LGTM, I wonder if there are other such redundancies in the kernel?

Looks like theres a lot left for this specific case. At least 48 show up
that are spread out across subsystems when running 'git grep
"GFP_NOWAIT.*GFP_NOWARN"'.

I think they should be cleaned up in sets per-subsystem to minimize
merge conflicts, as suggested in the commit mentioned above (16f5dfbc851b).
