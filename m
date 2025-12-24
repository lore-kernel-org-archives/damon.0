Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9C2D3732;
	Wed, 24 Dec 2025 05:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766554452; cv=none; b=T4PO3uP94UUBGgAAv0jxwYF14blARtwOerVh3V/Z5jEkkjCOQ7DlDkFcicF6zehhPAfZRfb11N6rFliApuspI8yvCX+UttgokWtKCfP7tWPRqQ6PeZvV7kv9UATVj3ENrRVSwTOFK+dXJlM4c6v9WOLGKOdeL95tJsmMpE3G76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766554452; c=relaxed/simple;
	bh=zLbx+xTupXnZyVSWwHXN/mFc292jJY5gpBhLh0NJUjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UL65/lUIEZRhcDXvRj2a/paxbRXVsdckPnFdfidUQfP6omQZx1ST20/ICrIzBhCxu4XD6c20mgqsQvk2abNnAYZRGZTdfBrlA8Its1Hwd/q9gZQSFo8sNIIZxMglM+D8cSwKwRhULOLIEFUVsUiLDq6m3RNvDoa1+i8ZNifS9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgufPEiV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgufPEiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D47CC4CEFB;
	Wed, 24 Dec 2025 05:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766554451;
	bh=zLbx+xTupXnZyVSWwHXN/mFc292jJY5gpBhLh0NJUjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QgufPEiVfZHHvxciL5ll7cKFyhoADE4nwvihwpP4RWBmiIYGyzbeFNUe/+nTnVDLi
	 QYVLUh2Hvs/a1gDo6k6EIR61XjwoYqWSyBplII4zjnOBGZuEkrZScvA70njC5SfqP+
	 dEJfwoEiuLmFx+XuNbhEqxSS419LE2qL31r8btfEth4vg+ZShlg6iaOaCu0/ii2UH+
	 AU9awsBcbSU16eS18PaXtKGg4iKp6T9NicEL2uoEQuz5G54qs2ImgCTBJulyOWtiTD
	 eXGwHuA88T/J3cPTkvBZa0Is7eM0JzRnr7StFDNeBIK/LObKjlvGSUgB3f+4oWaRPg
	 nBDu4NjZGfeQQ==
From: SeongJae Park <sj@kernel.org>
To: Shu Anzai <shu17az@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm/damon/tests/core-kunit: add test cases for multiple regions in damon_test_split_regions_of()
Date: Tue, 23 Dec 2025 21:34:06 -0800
Message-ID: <20251224053407.81911-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224042200.2061847-5-shu17az@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Dec 2025 04:21:59 +0000 Shu Anzai <shu17az@gmail.com> wrote:

> Extend damon_test_split_regions_of() to verify that it correctly handles 
> multiple regions with various 'min_sz_region'.
> 
> Signed-off-by: Shu Anzai <shu17az@gmail.com>
> ---
>  mm/damon/tests/core-kunit.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 2eb6f41635a8..36622a2c11f1 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -275,6 +275,9 @@ static void damon_test_split_regions_of(struct kunit *test)
>  {
>  	struct damon_target *t;
>  	struct damon_region *r;
> +	unsigned long sa[] = {0, 300, 500};
> +	unsigned long ea[] = {220, 400, 700};
> +	int i;
>  
>  	t = damon_new_target();
>  	if (!t)
> @@ -301,6 +304,24 @@ static void damon_test_split_regions_of(struct kunit *test)
>  	damon_split_regions_of(t, 4, 1);
>  	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
>  	damon_free_target(t);
> +
> +	t = damon_new_target();
> +	if (!t)
> +		kunit_skip(test, "third target alloc fail");
> +	for (i = 0; i < ARRAY_SIZE(sa); i++) {
> +		r = damon_new_region(sa[i], ea[i]);
> +		if (!r) {
> +			damon_free_target(t);
> +			kunit_skip(test, "region alloc fail");
> +		}
> +		damon_add_region(r, t);
> +	}
> +	damon_split_regions_of(t, 4, 5);
> +	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 12u);
> +	damon_for_each_region(r, t) {
> +		KUNIT_EXPECT_GE(test, damon_sz_region(r) % 5ul, 0ul);
> +	}

Nit.  The above braces for single statement is unnecessary.

> +	damon_free_target(t);
>  }
>  
>  static void damon_test_ops_registration(struct kunit *test)
> -- 
> 2.43.0

Other than the above trivial nit for the unnecessary braces,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ
