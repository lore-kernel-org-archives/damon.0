Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4054A492E22
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 03:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926083; cv=none; b=NF3At4GGboRG+askFYRVQE4JfXSN4Kog3myrYg8j682G1VkoS7Esf+iAwfu+UHYA0SE4fGOq+Nya3MkKluL/WjP7l9CqQASt0Oe/NOYAbIeTv4SiRC72lgaTvf38nALCfKIswyOTSf1eeKyFXJcUN9tD3Bn0IeWT6xX+W9iv8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926083; c=relaxed/simple;
	bh=Xiqqil3lhejwyFNGntLSKdddo5jmG4i9c0LXeFp46Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVHTcrU9UVSVaADMtIXmh01LmwI+77Q2hJbCrU9uZXJOFsaQTVXwTRxivO1Ek0GXfdRPmzpFjdOirdXl2f5+zmj5ENYrMDil59HJ9nIlzfD48u6y+aSV/OJuHUMGorjckCmaJ+sc6pgdtx5A1a6hJN/oy7fmXKHhvQ5SzsBgbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rlss1Exb; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rlss1Exb"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eefae4so5087335ad.0
        for <damon@lists.linux.dev>; Tue, 08 Sep 2026 20:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788926079; x=1789530879; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FVrTOgTm+0hJ1CwNzLVTB+HsMENUpTPm4cRxnxEzp5M=;
        b=Rlss1Exb4AlLHPFJRnzIwIFXJyIkCB9C87rDNndg1a5ViSAvUEhhBfkpmC0KOo5yXt
         Jwn+EbB/a3TnQHMsbzh+NvJRTJ8nkD0SjYAcyLyzO5U9sPpbIBKC19bSuv5vZiK6urgB
         Zh6uUAkQegs0GOCDx2AeDZ12b7aoHyDE//Fse521LoUarU1pnvQnhfnMwIt0CuvcuwCx
         sUkcsMNy+KAfsD9EBS2lLcKKf4bdcxfFMoFMlkZyuXC+0uhkucIlMLXJsNAOjZr2Zq1q
         ukdXqbg5SZb42/KcCTu2yxCpOiSFuLnXESLbvmrAHKp3Eu7XeN5vASmSKiy+4HDtLQZJ
         dh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788926079; x=1789530879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FVrTOgTm+0hJ1CwNzLVTB+HsMENUpTPm4cRxnxEzp5M=;
        b=pZczMmSZKh0atJ1t7IdmQDS7du9w8Fp+C8lYv6wTYC9eG3fc2Fmls6lgGs7EJIFfS/
         tuZ86/ZQqumfl8Tp4uUIFtBucR1NOgK9+qrQqfC8Gv9QRHsNORKnafecqMZ3cZgFoAej
         +zINmTGB7kuQNBbyWv3nBlAKP2eygLWoHqgBnpkoLn5TPvB+b7X973EI9R8eqXne6ZGf
         HT+t4hEyv1GJHWLrcYe1u2Zhd1NhJddnIriVZ6BWF5WMoNTcPcJyJh4xWObWbe/4WpTN
         Ib3ZjM97CW4uWkJeoCqJ+hqE+PvRdbQW6z0EvvfyzI4LKrhqL+CHsG9D6eEM+BHlcHU9
         u99g==
X-Forwarded-Encrypted: i=1; AKwUvBxr2EDdbsDXsKXL96YOWGtmHZNdjwF/A7rTWfg8eaPEVjM67OeJvOShb45v4G+xLtw7tKcPEQ==@lists.linux.dev
X-Gm-Message-State: AFuF++l8WYJ4JuECwwt2+G09BqTZqQwotOQFLSyGNM7gCENr5JhYQCCr
	JotcvK/t15hI++9t4ijwcyaJJP4x0xYbrWLSX8mr9yYCsg8MNHU+RiTz
X-Gm-Gg: AYBFou0jzmPvG2UaP8XDqEAk4izGWollT14HQ02UjIqlKcQV4th0xzqD/XjAo9F5IUT
	9xD3buVZkfnpjipqEWDqaRQyO5LG8x5EnXe9cQGBMopAYTJGm5nT9gLEdR2RTJzv8W8maLEb3G8
	SMmzoheBsQmQiRGs66f+AiW1zo7Qat1pIAkzM5Q7+En3t50aH7lAhwxAOQ130kYq9BbT04LLOr+
	zdvxuSu12Xt9kLIkbXGn94rq6YohwbKreho2JDX4JYGrU+MyQ7+ziUR/vd1po1djzJSlKQ2cj3F
	SNVKaxikRkGwx4D8V2SnRg70AKsRJ58fRGXCLqL/WZwVTXvlRG47JqfW8DFDEuuUn5/PZqA6pgz
	zUgQZ53rkw9/HVvyPd3SIyTZzK5C6BFtR2ujZp1yxqxOEOPR/lM/VOXN7nk7CVAEQMFf/joeIsY
	df1yHom7Mc7TUQaJsD2xJ+4WTm9wrSrcvzlM3toGDtE8uX4BSngIKSLPGKLcU/RTNcOQ/ZnRtGE
	E9vucpy
X-Received: by 2002:a17:90b:1c01:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-39b8bc95819mr8444097a91.1.1788926078043;
        Tue, 08 Sep 2026 20:54:38 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b07b197a9sm35037781a91.0.2026.09.08.20.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 20:54:37 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	akpm@linux-foundation.org,
	lianux.mm@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/core-kunit: improve nr_samples_per_aggr test isolation
Date: Wed,  9 Sep 2026 11:54:26 +0800
Message-ID: <20260909035430.2432886-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908133651.96278-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  8 Sep 2026 06:36:50 -0700 SJ Park <sj@kernel.org> wrote:

> Hi Kunwu,
> 
> On Tue,  8 Sep 2026 14:36:35 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:
> 
> > The damon_nr_samples_per_aggr() test sets both intervals to zero,
> > which exercises two different fallback paths at once.
> > 
> > Use separate compound initializers for each case so that each case
> > tests one fallback path independently. Also make the overflow case
> > use an explicit non-zero sample interval so that it does not depend
> > on the zero sample interval fallback.
> 
> Thank you for sharing this patch!
> 
> > 
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  mm/damon/tests/core-kunit.h | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index c01e6a75cad..ff23208c181 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -627,12 +627,20 @@ static void damon_test_set_regions(struct kunit *test)
> >  
> >  static void damon_test_nr_samples_per_aggr(struct kunit *test)
> >  {
> > -	struct damon_attrs attrs = {
> > +	struct damon_attrs attrs;
> > +
> > +	/* Zero sample interval is treated as one. */
> > +	attrs = (struct damon_attrs){
> >  		.sample_interval = 0,
> > -		.aggr_interval = 0,
> > +		.aggr_interval = 5000,
> >  	};
> > +	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 5000);
> 
> Thank you for adding this test case.
> 
> >  
> > -	/* Zero aggregation interval doesn't cause division by zero */
> > +	/* Zero samples per aggregation is treated as one. */
> > +	attrs = (struct damon_attrs){
> > +		.sample_interval = 5000,
> > +		.aggr_interval = 0,
> > +	};
> >  	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 1);
> 
> But damon_set_attrs() disallows sample intervals that are larger than the
> aggregation intervals.  Hence this setup is somewhat unrealistic.  Should we
> set sample_interval zero?

Good point. 
I checked damon_set_attrs() as well, and the `sample_interval <= aggr_interval` 
constraint makes `0/0` the consistent boundary case here.

I'll update the second case accordingly.

Thanks,
KunWu

> 
> >  
> >  	/*
> > @@ -640,7 +648,10 @@ static void damon_test_nr_samples_per_aggr(struct kunit *test)
> >  	 * overflow
> >  	 */
> >  	if (ULONG_MAX > UINT_MAX) {
> > -		attrs.aggr_interval = (unsigned long)UINT_MAX + 1;
> > +		attrs = (struct damon_attrs){
> > +			.sample_interval = 1,
> > +			.aggr_interval = (unsigned long)UINT_MAX + 1,
> > +		};
> >  		KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs),
> >  				UINT_MAX);
> >  	}
> > 
> > base-commit: d118502628f8b673be9023db8bdf878f64a7ed45
> > -- 
> > 2.43.0
> 
> 
> Thanks,
> SJ
> 

Sent using hkml (https://github.com/sjp38/hackermail)
