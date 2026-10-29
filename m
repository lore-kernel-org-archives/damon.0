Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287091;
	b=tGTFIpmFq8LmKzQqUusKoWIOC49t8J/X48o0TY8w8ncZgF0ewgdGUfPQ9fC5PUHv2m2S
	 mjzQrQGbk8G0F2OR4SU7Z9wQ/D/fjze89YjcAJi75VTtygW+6uVF0Nv/hwKElEGvIP00E
	 fXBuahbmXcf5m3pRSH+WtdyoTSygAF60Ci7XmsFK2k34whOxHGp5UArPC0ZHkMvdjjRH0
	 px25dG9O57uo5DaHqYKWa4Trgk+6PemSdCI7TCw68nG+5N0K46faEHXsQ8QUJ/WdI4qBw
	 jt27Hgf4H/K+UZ5jQm0mYYnKPCFvBpJb790pG/lt8VF5F8QiHEjGLSp0mV3SmycyjHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XKclWe9kzl34mf7ikCBlpHKdvGAXpEly40KTRKr1ZNY=;
	b=k2spsPY8cDsIe4AXHRgKQV0/A2DjqYzqW4qGtJEQka45VYRJ5gCujUzOWfwchwWjSVaO
	 Q6BjB+uacOWGKrc/ozURSRhcIG+wNSOsDbcc19EXBamXUvfnDUViAV8WzDaOUaXwuvI37
	 ClQK3JFu+/qVt7wajz/4uu+aXrOdKcPnIbXupMByYbkEqfmdq9O+nuyLQ4XZFP4v/JULg
	 x8A9aDDr7Tt8K9AiZpvYKl9UDxCSuSCVazBA1REPdNyJBMfNqTMyqNYI82tPjWYDdNIFO
	 8Mj1IPBeMcVFGq5gNXospWU/SxuAhHP8pkNJmbBDuaSUbg38omuqtNG2terp4V1KqVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e97AvZc4;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C684606A31C
	for <damon@lists.linux.dev>; Thu, 29 Oct 2026 15:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C684606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e97AvZc4
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so22800265e9.2
        for <damon@lists.linux.dev>; Thu, 29 Oct 2026 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793287090; x=1793891890; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XKclWe9kzl34mf7ikCBlpHKdvGAXpEly40KTRKr1ZNY=;
        b=e97AvZc4L/GuVp8aTzbEOyWAmh9wUy8nScv4IWTiK9/OuC/lBxRyn6oa2OgtDkfgZE
         l2vaKyD09QqSwoEOJGcsdBe/4Ky35RJNTybdtIIFJI0n5u4TLwK2OMmISLsgY1wsW2wM
         gNLcdcMhxIZY1DG49Jr7VwFjXqYguxwvpGfuX4uf4j+a/lF7Sj/1cqUXh0lBAF0mEizU
         wy+0Rmx9y8MqBI2sKTySPnvF4Rh6FhZJDNLXNVdaihwe0HitMXuV50sZi+Ya18Szl/p5
         pvVg+o8AqIeuEC20sdKLC0M5vKheVEE1HNUjhVvHzdRZ+mjYhB56+/vS6qOUnPqs1j0p
         sbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793287090; x=1793891890;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKclWe9kzl34mf7ikCBlpHKdvGAXpEly40KTRKr1ZNY=;
        b=JQPcD0+8EsfYaeCJX+AR+B+gXsJ5/if+59PGSF4EWjydXuB2ILBjzhe/HloE2yGRRN
         nf5/dDfEkGLDvDgfihKWrJj/zc2ARJCb/4GSGpt08mhzx/BFsBQsLwNoIg4qHR1JVDZ4
         7sxSV5YD/sAqgC0l+jlo4cV8c3TXY/RQbRyR4/pQRZP1tn5KBlRPwOMTG9pViDySlZp0
         JbdHKMqGYoGadtna7sPqJsLwvT8vzCECPZnrVymYJChGECDCWg/pdaP3tWicVjrRszR9
         ZCVRcDCRTFaDxTZughgmu81+uSWuLAXcIenbwZW1s5dAVNkcBEZQuCbbMi14t/n2iwAy
         MGrg==
X-Forwarded-Encrypted: i=1; AKwUvBylT2ZwBJ127055KM3e9aYohp5HfM4svC6qvz0l9wfyG8OI5Ak08nYg0Mm/bYqgbK5JS/B+mw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ/JPNk6oTOGYgr3fqX3eOCKT+1vbbgo5lAQDRWFLfhHxKcRn9k
	mvfcy7fgFmpS1F9J3q22PjYfNGmBjrOVJoqwdwQQvXCk/kJs0FWknOZ6
X-Gm-Gg: AYBFou0YvXROT/5Gbo7UWJozIEarB5hnQHfdLRPmQ/l7l0WI5X3huL67NnaZUCd34mf
	TpAIiVzAPFOBxwFy49+iTixf+uG2wd1GnWnV0ldtBZ3xH40XXbszM0eUa3qwINByLS1OFcJPwCs
	sDZ7ZKK/DFogeuaZK4r0iMe32hCtbU0Meydrajd0TnKAKIPMs2dqmYSOWDCFI44SpEPZoFkNNiP
	Yx+DxTgCuB8cLoxo6PhUPO+O0UFAAkNLz9rBks28yp84XrbKQGE3E6s4IGQovPRHFr2GTBfF1x8
	oIPNHq0oVbzcN/Pl6DhcDGa5lYrJuSJ0HPfLhSArMotXsUAL0gCTHfvkWudOT68xA3kV6gOIhGJ
	+XMn9dOpmPMMwQxLBGGRPhouGLHb7MWu0PVfs+zGrl+JAm+SuDmrn6h4pLCmP/fKaaDu8motwlH
	pk12byJndpdMDiwN1Zf1OkvvE5kw1zDKKiis1W0fsNwFxDAHf7+X0ar/wn3aTqGQ7+KKasZUHBD
	gIx+e98UKxczKnRQjGfhtpyaf1BQRXEnCgCoN731np2dl7MRG04KXVEXujzOuE3R2VtrTm48JYL
	X7nf2/BVND+o4h8/z8Me/iee/v2bL7ditoUeDFGNPchyF72DZZABzpL08+554GFBRTuERJ+w66Q
	J6DkkfbpWxpw90DsImD6Daa+Y8tTLWEDxXuLRAoQ+SBiIWjaPc6KM9jIBEB5BdGmx33U=
X-Received: by 2002:a05:600c:4f89:b0:4a1:c6fd:4db0 with SMTP id 5b1f17b1804b1-4a966c41836mr142852995e9.19.1793287089736;
        Thu, 29 Oct 2026 08:18:09 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94f05e4e4sm87571055e9.3.2026.10.29.08.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:18:09 -0700 (PDT)
Date: Thu, 29 Oct 2026 18:18:05 +0300
From: Dan Carpenter <error27@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Xiaolei Wang <xiaoleiwangxiaolei@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	"Liam R. Howlett" <liam@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/sysfs-kunit: fix leaked pid reference
 in add_targets test
Message-ID: <auNjrR4FyTf4WbgI@stanley.mountain>
References: <20261029075609.35661-1-xiaoleiwangxiaolei@gmail.com>
 <20261029141040.148392-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029141040.148392-1-sj@kernel.org>

On Thu, Oct 29, 2026 at 07:10:40AM -0700, SJ Park wrote:
> Hello Xiaolei,
> 
> On Thu, 29 Oct 2026 15:56:09 +0800 Xiaolei Wang <xiaoleiwangxiaolei@gmail.com> wrote:
> 
> > From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
> > 
> > damon_sysfs_test_add_targets() creates its monitoring context with
> > damon_new_ctx(), which leaves ctx->ops zero-initialized.  Since
> > DAMON_OPS_VADDR is zero, damon_target_has_pid() returns true for the
> > context, and damon_sysfs_add_targets() therefore calls
> > damon_set_target_pid() for each target it adds.  That function grabs a
> > reference to the target's struct pid via find_get_pid().
> > 
> > The test then tears the context down with damon_destroy_ctx(), which
> > releases such a reference from ctx->ops.cleanup_target().  For the vaddr
> > operations set that callback is damon_va_cleanup_target(), and it is the
> > only place where the reference is put.  The test never selects an
> > operations set, though, so cleanup_target is NULL and both references --
> > one for each of the two damon_sysfs_add_targets() calls -- are leaked on
> > every run of the test.  Running the test with CONFIG_DEBUG_KMEMLEAK
> > enabled reports the leaked struct pid objects as unreferenced.
> > 
> > Fix this by selecting the vaddr operations set for the context before
> > adding the targets, mirroring what the sysfs interface does.
> > damon_select_ops() fails if the vaddr operations set is not registered,
> > in which case the test cannot exercise the pid handling and skips
> > itself.
> 
> Makes sense.  Thank you for finding and fixing this.
> 
> > 
> > Fixes: b8ee5575f763 ("mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()")
> 
> The impact is leak.  I think we should add Cc: stable@.

I wouldn't bother Cc stable for unit tests.  It's not something
which affects production or real life at all.

I used to be a be more involved in testing and the rule was that you
pulled the tests from the latest kernel and ran them against the stable
kernels.  It feels like that can't make a lot of sense for unit testing
so maybe for unit testing we didn't do that.  I can't remember...

regards,
dan carpenter

