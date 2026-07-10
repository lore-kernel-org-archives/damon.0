Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708D2EB859;
	Fri, 10 Jul 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692167; cv=none; b=B4TNkYvZZ9p1Kj5x4+jMMwbgkkgj05ihIVoIK524MCbr+VU7Vjf9vW4C4G8hYD2qm93SWIY1hytlqNz0NCTC90/znCXTh/z70/PKpNY/05RexuPQ2DHIgieIbxGU/8JI8AU+do21fZeHhlv3gfukIlS9207Rel4HDPS6VsNO7nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692167; c=relaxed/simple;
	bh=cewSjUdjPi8U6Y+sdEb12dpTAkEEBIlqjz8SZdac7Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T37mitwb21X4r3akS9dSYDc+BhKos3OURVbBsdjmnm399xgfMK3bLvxNpzyMAUd05qVcufOObt5+kds0FxSLhfZtE731sWsdESnCq0c/R/pENtVwtSDwv75dLR7YezCF7RCBUYYCJyZ2Zo0dfoC9Pw8BDRAeLdqs/5+Wn1liqYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVqzTa4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVqzTa4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1481F000E9;
	Fri, 10 Jul 2026 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692166;
	bh=YXRFFkLYVns1/+XFmHFxA02oUx/vG7e6oaudilozWhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NVqzTa4sCRa2i+lQ20ttLl8+DYSA5pV41sI1EMXc8DLGzL0+p9SAXYy7+73NBq/gY
	 s79VGcmES1x4l0YI4xlc9XoQwwVpnHGEvCXnUW/qNozPSdTft1SVFzrQhLe7Rx4ZLj
	 R/majU9cH8n9+ILjd04KtELbscU5sfIaSR8A7aL9gOWkk7G6WyydJOSk6tqRC5N5hM
	 jfL8I0lfhjBhLG2evyMEoyptCl1EONDwAL2BekQDGtZiRxFZnWMd89N/Nz9+uYd4mU
	 R3Hkgx4EXmbPdFj1e92mE5D7jPM81FV8vTEpo+WE977Iy4N5e+S+ky/zWJ8GsJAoWi
	 tKEtWZ2ufe6FA==
From: SJ Park <sj@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	shu17az@gmail.com,
	jiayuan.chen@shopee.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/core-kunit: test damon_nr_accesses_mvsum()
Date: Fri, 10 Jul 2026 07:02:37 -0700
Message-ID: <20260710140238.24103-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710041530.557455-1-husong@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 12:15:30 +0800 Song Hu <husong@kylinos.cn> wrote:

> damon_nr_accesses_mvsum() wraps damon_mvsum() with the monitoring
> intervals of the context to compute the pseudo moving sum of a region's
> access frequency, with a special case for when the whole aggregation
> window remains. damon_mvsum() itself is already covered by
> damon_test_mvsum(), but the wrapper is not.
> 
> Add a table-driven KUnit test that exercises the full-window-remaining
> boundary (with both reset and not-yet-reset nr_accesses), partially
> elapsed windows, and the no-window-remaining case.

Nice!  Thank you!

> 
> Signed-off-by: Song Hu <husong@kylinos.cn>
> ---
>  mm/damon/tests/core-kunit.h | 49 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 0124f83b39b8..8c030282a638 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -683,6 +683,54 @@ static void damon_test_mvsum(struct kunit *test)
>  	}
>  }
>  
> +/*
> + * Test damon_nr_accesses_mvsum(), which wraps damon_mvsum() with the monitoring

Please wrap lines [1] for 80 columns limit.

> + * intervals of the context.  With a sample interval of 1 and an aggregation
> + * interval of 10, an aggregation window is 10 sample intervals long.  Each row
> + * below specifies the passed sample intervals, the next aggregation time in
> + * sample intervals, the current and last nr_accesses of a region, and the
> + * expected return value.
> + */
> +static void damon_test_nr_accesses_mvsum(struct kunit *test)
> +{
> +	unsigned long input_expects[] = {
> +		/* passed, next_aggr, nr_accesses, last_nr_accesses, expect */
> +		0, 10, 5, 3, 3,		/* bp=10000: unreset nr_accesses ignored */

I was bit confused what 'bp' means.  Can we just drop 'bp=...:' part from the
comment?

Also, let's keep the 80 columns limit.

[...]

Other than those, looks good to me!

[1] https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings


Thanks,
SJ
