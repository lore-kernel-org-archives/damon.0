Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28453192B86;
	Thu, 20 Feb 2025 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089689; cv=none; b=gS0yB3W1+t0B7aZg7GqQBkWAhLNpp/OxsLn7eFbcNx0+qurCTQP9RTMx64HQNy5G716HQQ5m+dE+04KTkDph6Fg9iK0x9pfM/EdidVnWQW9EcrUBxNWRhY0Zhe0FlKaSYelnDO4uuSmEpZeGiYFIdOuU0dP3j/w3x56qj/fCAg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089689; c=relaxed/simple;
	bh=zhDIxuQ136+RGJi0J8GufU4CCYD/wr4uuq3P5v1FcPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAm1wvbWfcIUwC9erTrNfcs0j82u47fvPOFq5PAtBOqFgel6/fkjzcqOhu1yrYzxUlxeKjxSyyMDCPrBAQR1yIri4RvfpDSK0DIijwu2bKrAjNe0SK1vbRVJauP3gC782Ps3stzOYLQBi6x/w7TqjlTNeODWaCbCgpkwR2DuTUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGW8xvOX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGW8xvOX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B81C4CED1;
	Thu, 20 Feb 2025 22:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740089688;
	bh=zhDIxuQ136+RGJi0J8GufU4CCYD/wr4uuq3P5v1FcPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGW8xvOXcqVhfz7iG4eAZNgSQ/5vq6S3cb8l7b6SmqF4M2upK495+ZCgxuXxxLF2t
	 45S5+nigcK13R7A8rRwVz1uQCDT5i6usSuCYMzGvfqbV5y/N/H2TE9MZTL9lUMNXYc
	 kcWR4t7TPjg5Er/nRWuz6+thQxkui51i3ZgxD/jj/gzHGc1/pKGIDs6GY2ZmCB+Rax
	 LPMWDIOHMnZNFwU/01PMHOdoXG08lji7Ey2ZT/TUHJqYkyjSnjhXmifWvsIKLYibLT
	 2p2O0NZldbYmB9xuUbTjG3QTXKohjU6ktHqTi5vMalRc+A9ytu303fdfqRjUA2oZ7K
	 CVra70oPzqNOQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/8] mm/damon: add sysfs dirs for managing DAMOS filters based on handling layers
Date: Thu, 20 Feb 2025 14:14:45 -0800
Message-Id: <20250220221445.39118-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220194646.37726-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[...]
> Also note that this patch series depend on filters default
> behavior change patch series[1].
> 
> [1] https://lore.kernel.org/20250220193509.36379-1-sj@kernel.org

This is an RFC that depends on another RFC patch series I listed above.  But I
made yet another mistake on the subject.  Sorry if it made any confusion.


Thanks,
SJ

[...]
