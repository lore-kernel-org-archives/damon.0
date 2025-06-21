Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3FA22DF8B;
	Sat, 21 Jun 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750529490; cv=none; b=lnwwXZY9VnUvNEtMnYHD9oZJW6rvLHAroE8SEfxKIzIlzNH3E/p6hEZJVuUxfrhj4bzTLWrH1tgb6xqozAGuz4ng4g9MYAKW+z68mgotf72FfceIIXPFEWbqMoZHaJhJjuj1DdWYZosdO5gMorjWzClahj4hKfrz5IC23b3v6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750529490; c=relaxed/simple;
	bh=GyZin8tK1VU+mB4hRLpjVwYev+eqiENeiPNpM1Tl1nI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sBxyjxDBXpxRPVI40O3oeqI7gS/UaA/tT/jOvxziJ1KpCYHahC2zd/a5iYA1em9u/nZy5AAA8AizK6oVBqIVu32+pNPnFpMBuPqIGx2YS3XEgzKk5wsSYQOLsSnL10vUwTC0alo2y4vt+aB6/2oDXauNcGZnQ6u1ZGLIWVqR0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+TXSuBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+TXSuBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5587CC4CEE7;
	Sat, 21 Jun 2025 18:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750529489;
	bh=GyZin8tK1VU+mB4hRLpjVwYev+eqiENeiPNpM1Tl1nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+TXSuBmZls7c39WpvaP8YgHY0BKdiHXIbiP+7ETgSOG5mXJAPJtwoCbUM4f3aI7Y
	 Mn+/v34lDAHLlStZsIRHtKds6i6VxnCtDXrjEYQNO/cZHoRv33UzM1OkbwCGZDa6pB
	 y0rHCJeUp5v/jN2JpLmTY6qj/D6rzJi1knoja59xm6IIitFWZhpT1X+F3Tpo4SmyLe
	 lkLjoKfM0y35EUsGNQRmwCpwtlnF+D2ugvLo+hhmInc78INPf5AvV8kdARZge5CO0Z
	 2H1TFVpcsmqkg8RZZrh2MdQSigO7rv1BhAfhLQqXMnYeUigCd9AGTAyjmoZz2I2EMi
	 U+K1b64YjaqlA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 2/2] mm/damon/paddr: Allow multiple migrate targets
Date: Sat, 21 Jun 2025 11:11:27 -0700
Message-Id: <20250621181127.36394-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250621180215.36243-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Jun 2025 11:02:15 -0700 SeongJae Park <sj@kernel.org> wrote:

[...]
> I'd hence suggest to implement and use a simple weights handling mechanism
> here.  It could be roud-robin way, like weighted interleaving, or probabilistic
> way, using damon_rand().
> 
> The round-robin way may be simpler in my opinion.  For example,
> 
> unsigned int damos_pa_nid_to_migrate(struct damos_migrate_dest *dest)
> {
> 	static unsigned int nr_migrated = 0;
> 	unsigned int total_weight = 0;
> 	unsigned int weights_to_ignore;
> 	size_t i;
> 
> 	for (i = 0; i < dest->nr_dests; i++)
> 		total_weight += dest->weight_arr[i];
> 	weights_to_ignore = nr_migrate++ % total_weight;

Actually, probabilistic way may be not that complicated.  Maybe we could to
below here.

	return damon_rand(0, total_weight) >= weight_to_ignore;

> 	total_weight = 0;
> 	for (i = 0; i < dest->nr_dests; i++) {
> 		total_weight += dest->weight_arr[i];
> 		if (total_weight >= weights_to_ignore)
> 			return dest->node_id_arr[i];
> 	}
> 	WARN_ON_ONCE(1, "I don't know what I did wrong");
> 	return 0;
> }

But damon_rand() might be more expensive than the roud-robin way, and arguably
roud-robin way is what usrs who familiar with weighted interleaving may easily
expect and even prefer?  I have no preferrence here.


Thanks,
SJ

[...]
