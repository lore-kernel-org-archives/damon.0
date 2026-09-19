Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7C91E9919;
	Sat, 19 Sep 2026 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789837331; cv=none; b=QN4V0Pb5YMtzlw75dm2UEBo+Z65AY1PZjvQmqR7dprYdGtX6A7MARHNLE9QM9NEEmDeeyGx5tczHC1LSfLW7MLEP60yKuOmPY5GicimNjtsW8kDdaBCs8Jb6kOSIoU6aSGkzP8MV/mvIh3eDv5cXGMjjrk6yX5Xv+R+Vb0d3Po0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789837331; c=relaxed/simple;
	bh=+D4+6aJDD7rWfm6euBL7wtzq4CbXXb4TzLXUfgYTzkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGRHB20tWKQX2s9O55P1uaQS392Ii7EbSWKpO5Zy+6yydSmPiVwHJfDii9YZfOgkBId+O0hNMVLqZuepAkIUXIc3ZP3Fy98WzMnMuDcfUJd0DrpRlXR5sIGsCCspzumRINaoZ6G4twz4EJ8AtzsHoRTTk6gTzzXrny4cFE2EBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7+8/d5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7+8/d5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C47F1F000FF;
	Sat, 19 Sep 2026 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789837321;
	bh=yuyxk49VJCC0gfGldxmcbzu2cmMU5n1fpWdo47YM2lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E7+8/d5P82fP2xzrq+MJOLKng5m/Jh2jBtTdayiM8/U1717rxb8gAdXZwRMhSGA3q
	 hWDSkZwCVpfLauWzcLeGH+WAFpU21KcXzILtXuBWA9pZ25z5CrIpt8HF7TSe6ynH2k
	 Lo1hmEBG5qCMmdKOvd5K9080CKiJdPXT+96nnTFDmQXiF5BQX11WlGYLHEvDac+gp5
	 UcugU0EW5KAGditkMe0HUiCbtn+pPO+jKc0x/rt2AqOjeudVywOOEh509tle86YxbX
	 caEYL7sxB5OHGZ2gLetVhVY6zBS9N7UdMh03hIwwMUDd08Qhjp10/MlW823YM2C6zt
	 1eCdELUbfmQYg==
From: SJ Park <sj@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon/tests/core-kunit: test the temporal tuner's size quota conversion
Date: Sat, 19 Sep 2026 10:01:54 -0700
Message-ID: <20260919170154.86842-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919071324.1583280-3-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 16:13:24 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> damos_goal_tune_esz_bp_temporal() encodes the size quota in basis points,
> so the conversion is exact only up to ULONG_MAX / 10000.  Pin the three
> sizes around that boundary: the largest one that fits, the first one that
> does not, and ULONG_MAX.
> 
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
>  mm/damon/tests/core-kunit.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 5ff0436c5844..4460dce0352c 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1929,6 +1929,40 @@ static void damon_test_rand(struct kunit *test)
>  	}
>  }
>  
> +static void damos_test_esz_goal_temporal(struct kunit *test)
> +{
> +	unsigned long max_sz = ULONG_MAX / 10000;
> +	struct damos_quota_goal goal = {
> +		.metric = DAMOS_QUOTA_USER_INPUT,
> +		.target_value = 10000,
> +		.current_value = 0,
> +	};

Let's use damon_new_scheme() and damos_new_quota_goal() unless it makes code
too complicated.

> +	struct damon_ctx *ctx;
> +	struct damos s;
> +
> +	ctx = damon_new_ctx();
> +	KUNIT_ASSERT_NOT_NULL(test, ctx);
> +
> +	memset(&s, 0, sizeof(s));

> +	INIT_LIST_HEAD(&s.quota.goals);
> +	list_add(&goal.list, &s.quota.goals);

Let's use existing helper, damos_add_quota_goal().

> +	s.quota.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_TEMPORAL;
> +
> +	s.quota.sz = max_sz;

Meaning of 'max_sz' is bit confusing.  Why don't you use 'ULONG_MAX / 10000'
here?

[...]


Other than above, looks good to me.


Thanks,
SJ
