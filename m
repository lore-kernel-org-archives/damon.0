Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB71285CB6;
	Wed, 24 Dec 2025 05:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766553978; cv=none; b=la8f/dKahMGiEPsMyqmmsKUXzJi2p/2CKWrg8CzPw8lvjfIM9o/amr0ANGsQIhltpkFZyS1nc7eIAvAxBMsKgdmMxeI4kSqzDGuSOQnDa49ZTBcOQXG1XBp7GivIPYCu9ZdbwCaH85ZqcTXYTLo9Y94qBAhTJpWg3U6yaZU47lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766553978; c=relaxed/simple;
	bh=w+yqxVPmNSXi64h9c/SbjrKYVAMQ3Vg9fRqikGkucIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqlIoiJhHc/DoYFrLzGukAoBxCZsKrdcwJZEgglPY3369wNkYVQVKtAWim9/P6Je7cO9aWVuGjrXhVGCZgooKpFn1oIazNf5yut2AbAPmdi2BnzqegK1u9WMjS0yeQ4X+gjIEwQJDN4Wq5jyPjzqp1kWrSnr9q6KD7j5zb/fWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcOL2azk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcOL2azk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759AFC4CEFB;
	Wed, 24 Dec 2025 05:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766553975;
	bh=w+yqxVPmNSXi64h9c/SbjrKYVAMQ3Vg9fRqikGkucIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcOL2azkZYxadIUBw3zX8ZlWM8l/iXVQI74TTFk60eFTUwk2LT+yXfrTzhev0j9Ag
	 JmG31EbftpPHFsF7TPoeJOe2Eu+3CvQPdQOyX/uLRjjrQHLAlRfyEY1DmaS9zTY481
	 q/tlBIuGFrVFulWdUpIIvIyBpp9uUvpYnpHNyow4WC7R/H0c/xVv2jdRlwl/QZmTH9
	 XNekgrgtd4E6XomwSbKaP6gAbXzYOOqKlqRSDTXS6hVg0fU4EDLuE/03AqTPQa+4Dm
	 tGlz0ZfWl4OoGhzUhxUZYcYx8Uxl5JzNpEkM5P56doPg7BlbXrmELBZ9f043jJFv2n
	 mLm7L4MPoh8Zg==
From: SeongJae Park <sj@kernel.org>
To: Shu Anzai <shu17az@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/damon/tests/core-kunit: verify the 'age' field in damon_test_split_at()
Date: Tue, 23 Dec 2025 21:26:10 -0800
Message-ID: <20251224052611.81594-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224042200.2061847-2-shu17az@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Dec 2025 04:21:56 +0000 Shu Anzai <shu17az@gmail.com> wrote:

> Extend damon_test_split_at() to verify the 'age' field.
> 
> Signed-off-by: Shu Anzai <shu17az@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/tests/core-kunit.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index f59ae7ee19a0..88ec046f4942 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -158,6 +158,7 @@ static void damon_test_split_at(struct kunit *test)
>  	r->nr_accesses_bp = 420000;
>  	r->nr_accesses = 42;
>  	r->last_nr_accesses = 15;
> +	r->age = 10;
>  	damon_add_region(r, t);
>  	damon_split_region_at(t, r, 25);
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
> @@ -170,6 +171,7 @@ static void damon_test_split_at(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, r_new->nr_accesses_bp);
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses, r_new->nr_accesses);
>  	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
> +	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
>  
>  	damon_free_target(t);
>  }
> -- 
> 2.43.0


Thanks,
SJ
