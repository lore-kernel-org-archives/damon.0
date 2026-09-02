Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE804A49B7
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361735; cv=none; b=k2nJhIItlDVODLXkYZToOJkB0mt0oDbeQqIoD3wiboUPTfPrIEFeAak/1u3aExQrMiRmVzuDdV1nPwr140mpmLfvaFd2ayEmOrKFkwcknzzh+QuLjreORpbRdKdgfGedm4Ah15N6aA2n6rQJDiMsxtInrTGImpCd7OqG4OTWSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361735; c=relaxed/simple;
	bh=I3mYKVGTKqP/H3LNKqz4oW31/g3MR2FuJzgjMuRu5I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gg2hFWkHMeZ74eaWeqiIJaCQnbI3ZDdgbsUVfRCd7Xi4NuxEB+oXkIyJfcx49aOOYgXZlBaw0+fEwXzjuEVQP+BfJAPZlNKa+ZTq7Bgc4+1J+GtACHIQqwcPWiCVbj1CnZz6ITs4LpME3vbfV2QjKxiqtlPJthwrKqakwedOO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTILltGn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTILltGn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6d28aa26cso7706035ad.2
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788361732; x=1788966532; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EIdbnMs2RBr+E/C3ONkDjLCzcgL/LziyquabNv/nyLY=;
        b=TTILltGn/FiQdZzgAwQ+b196ZXOe5ydK36lY6h1oEgnnTvxaqAmuJuUucVvmnf7gWt
         guTP71M7+BWTdt1HlwqQtuXhBoEs/k31c77w1T5RWrDozbgoApTioEO80AVm8dLUZkiK
         uB8tF6izP3FXVRRBT5DhsQFzbfPhGJFk9ruf+wKvmUn4/uFRxOjRFkQYT9/IzZ6SoARf
         EBla+7EPcvSTu0Qx3sMYQxD1FVBY022z0LwX81+FBsQHYU5CTF+mz7AvvFxngSJR6+qF
         sUNnQ7R+5SrnOKxqBWRF0doDQw7lBAUmMpvzAzVkotldcovQvSByRHkPDYylZOGIrgaP
         YEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361732; x=1788966532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EIdbnMs2RBr+E/C3ONkDjLCzcgL/LziyquabNv/nyLY=;
        b=O6vN1Gc4m4Zh5Osw5dLPxopRj+s2uIGn/ffghYOeSnokedKkZ7uFLUY8e2P8aJpU+A
         HylVhJIOaDAWJ7pDdggvO+NyQ/AHHZwvtvDtztkiItZk27deQjRbD6uP/GZyBWuO3Bhe
         OXpvpQS2jZgPsj+fLWEglLZpMUY3k+DEgMxgd/kMI9Byi6enCP9HxwyVBbcf6c9AKE2X
         vo0rpmtkOUcfgB2rV+Gnw6phe4QSHZR0B1ezvrCDueQiKLC+qfZitenqgNzzNGtHuoFN
         pDE7gH7xRLkjOeYqp6hAW/c3TT2Qu7xqDKOifXdRNsSFNmb2Sw/UL4zuW99ugEQspK+s
         3xNA==
X-Forwarded-Encrypted: i=1; AKwUvBySgH2f/gvDKAh55Xmmj/MISxxaC7pI99ID9mQ1g/sIvEokKKi0gTNoUymaprH9AN4C5uLakg==@lists.linux.dev
X-Gm-Message-State: AFuF++mk+WzKWiwj4ho16o2O3iZ3SKSTeWCUvQuOp7zYCWfrb0kfTlIg
	3jAVtKlkI5b5MfIz5YdQ6+IWlqWvuf6ZAh3pKomnDTH731dLDV+xW2Uq
X-Gm-Gg: AYBFou3965U2nptIH4P+PqndJ5p3Rl1CryDgJR4SSzGInIszFy4rkLElp8+UKzot1Pz
	eVTiV7qkRUgp1p2eHWOFi02BZ1YQvGNqp8PZNXXcREpDW2apney5pkMBxL3lyD7G5a0N9iaqw52
	s9Ix5v8wwt3x26KAt/UG8vkQdC2LQ/qwGyCLll7/9YliKkiN/cOn7Rtuee9phPK06BbE8wVGCM9
	cPRfN2un3ObpmNOpWRzq26xpnpikPmf0a0gQozrcacrsmS9r5J5xkS8rp9h+uOqmgX9OzidpEal
	O3ZBbyn0U7/XB2OPtVy6TRWMQ95rtVkCFSf1FKUx5pVvjekIxJD4ICUrXvCgSLzYvVBQU1PsQto
	bho5fTJ8T3GWDxkb43EEArRqoQgo/HyMk7jI/S4vsYGBQouq+CdBTISfzQA1YLZFusntFt+tmBy
	EOEvgDtNWsIFIZveQJGvp7g0FHgXkOxX26j2UHcDwp/p1SlwiUF0ZJa4uLC5MX
X-Received: by 2002:a17:903:19ec:b0:2d6:e4ff:9cad with SMTP id d9443c01a7336-2daec5ab9c5mr86317615ad.3.1788361731078;
        Wed, 02 Sep 2026 08:08:51 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd488d18sm15030855ad.45.2026.09.02.08.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:08:50 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 09/12] mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
Date: Wed,  2 Sep 2026 23:08:41 +0800
Message-ID: <20260902150842.4033320-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902054747.99370-10-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 22:47:42 -0700 SJ Park <sj@kernel.org> wrote:

> damon_max_nr_accesses(), which is a previous version of
> damon_nr_samples_per_aggr() before the renaming, was wrongly returning
> zero or random overflowed values for extreme intervals setup.  Commit
> 35d4a3cf70a8 ("mm/damon/ops-common: handle extreme intervals in
> damon_hot_score()") updated the function to return correct or more valid
> values.  Add a kunit test to ensure it is working as expected.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/tests/core-kunit.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index a4164ac489a61..d0bed01a5b7fe 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -625,6 +625,27 @@ static void damon_test_set_regions(struct kunit *test)
>  			(struct damon_addr_range[]){}, 0, -EINVAL);
>  }
>  
> +static void damon_test_nr_samples_per_aggr(struct kunit *test)
> +{
> +	struct damon_attrs attrs = {
> +		.sample_interval = 0,
> +		.aggr_interval = 0,
> +	};
> +

Hi SJ,

A small question about the first test case.

Both `sample_interval` and `aggr_interval` are zero here.  Since
`sample_interval` is the denominator in `damon_nr_samples_per_aggr()`,
would it be better to keep `aggr_interval` non-zero when testing the
zero `sample_interval` case?

This would make the test explicitly cover the divide-by-zero protection.
If the `aggr_interval == 0` behavior is also worth covering, perhaps it
could be tested separately.

Thanks,
Kunwu


> +	/* Zero aggregation interval doesn't cause division by zero */
> +	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 1);
> +
> +	/*
> +	 * Too large aggregation interval on 64 bit system doesn't cause
> +	 * overflow
> +	 */
> +	if (ULONG_MAX > UINT_MAX) {
> +		attrs.aggr_interval = (unsigned long)UINT_MAX + 1;
> +		KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs),
> +				UINT_MAX);
> +	}
> +}
> +
>  static void damon_test_update_monitoring_result(struct kunit *test)
>  {
>  	struct damon_attrs old_attrs = {
> @@ -1736,6 +1757,7 @@ static struct kunit_case damon_test_cases[] = {
>  	KUNIT_CASE(damon_test_split_above_half_progresses),
>  	KUNIT_CASE(damon_test_ops_registration),
>  	KUNIT_CASE(damon_test_set_regions),
> +	KUNIT_CASE(damon_test_nr_samples_per_aggr),
>  	KUNIT_CASE(damon_test_update_monitoring_result),
>  	KUNIT_CASE(damon_test_set_attrs),
>  	KUNIT_CASE(damon_test_mvsum),
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
