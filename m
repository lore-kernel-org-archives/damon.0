Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3BF10F2;
	Sun, 10 Aug 2025 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754843855; cv=none; b=jc2fLg9AfZUIddF45bgvQugVEnc+B2p4UtcG3QwrUXoEDa/zpehnCLqskQq6LLM8Nl1syddo401BMMA3DedHZbDx4dm2GWYyBseRrOJrAVFLXa/Ifu58hyyd7OD65VfL8ePQ/8IpFsRvKDSn58SxclnC7mpBX0c4eDdWjy0o6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754843855; c=relaxed/simple;
	bh=mU1CU6QSs1t+ZnPN5+7CkO8QO1LKiTJxVkyoIEy/7DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Riz26Ibu9PzarjO3S8Yt7dFecrkoWd+g2U7XopbtinzU2NcbsvI9D+yIxun/jSdKkaDcn57skwx0GPG2NDzSXJ02n/s7G9l2cRoGTALK1uZ3XyEKs3LbX/1IcLWsJp1+4/y/wwUsfp2umoMy30y3u18j+liDbUNtjh1Ba8oa4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVIfroHM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVIfroHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F58C4CEEB;
	Sun, 10 Aug 2025 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754843854;
	bh=mU1CU6QSs1t+ZnPN5+7CkO8QO1LKiTJxVkyoIEy/7DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVIfroHMubMtqvBRBUD1Q+6yobVn31zakpY8QNNodPCB/8XjGjKL835sRY4waCrrr
	 q0rr6VT9V8Gzh1UMUNuoBP6HKF1OmWyjEp+Csb/cXnD2+fB6bR9t2ufD6t84EpBeju
	 HiKe6SJ7xBC0HFXTTpQzjLlQIeHCV++zWwddomokddZiJnGCIm4zK0M/nIqRbgAE9a
	 57Hz+2qNjrnoEUi+SSBLq4XjHeMKB1xLlYmT5TQlDB4wwAG//HdMQOZtRScS9w8uIL
	 P1K7f8diiZ65c3NcRhuS5xgUztipEmQFwrHf9/3PdBRuU7qa8TEd/rrhqGB3FJm5Ec
	 TYQLafZ4buYOw==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] mm/damon/core: fix commit_ops_filters by using correct nth function
Date: Sun, 10 Aug 2025 09:37:32 -0700
Message-Id: <20250810163732.45668-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250810124201.15743-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Sun, 10 Aug 2025 21:42:01 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> damos_commit_ops_filters() incorrectly uses damos_nth_filter() which
> iterates core_filters. As a result, performing a commit unintentionally
> corrupts ops_filters.
> 
> Add damos_nth_ops_filter() which iterates ops_filters. Use this function
> to fix issues caused by wrong iteration.
> 
> Fixes: 3607cc590f18 ("mm/damon/core: support committing ops_filters") # 6.15.x
> Cc: stable@vger.kernel.org
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
