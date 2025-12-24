Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32475285CB6;
	Wed, 24 Dec 2025 05:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766554061; cv=none; b=ezBHfarhX7gj/XjwQoCv0rlDrm1WqM2hbl35mQmEdsBRWdjnsQexWPkM3pDOclyyEtC550X28Z/Ju7r1x+Yu9rViwevddu7wLOxdJY0ujxVtoGzlokbyl1iBvqeefUJdlHdozAVKnMCdgKotZ+6nnwejyjLbW5wWnM9/2vhuH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766554061; c=relaxed/simple;
	bh=QDD2sVHnW4PwLhM9+5VNIHHAmrIHl3UBjDIC8SA2AdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tn7YtQviuKNgyd7GLMqs0GK6JyHazghOTezIQOitDNz5s2EX4UwDon1jeKAxveeNRILNMoXfYz30GFfSR+xwxjHXJsamS4fZRhH+0xmGsCrXBaE8hgyxtYqq4014RFrxB54elcCyYCNBD5Fq3yMbSBQq+o/SV3ti4QxEIAyz/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBN9PvLW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBN9PvLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4649C4CEFB;
	Wed, 24 Dec 2025 05:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766554061;
	bh=QDD2sVHnW4PwLhM9+5VNIHHAmrIHl3UBjDIC8SA2AdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBN9PvLWUFGOeKoJtoX2EHuqBhvQIVCL7wohcinsBgPE9A/kqIfTPo48wvLw1FEY+
	 wSMgIjUvX7aZgxxgTgE2GeIApv1lPQPpL/lzrjKI5KKE5zCJI+z6e1V9sTzlQhBPH3
	 o5E3tTltwe7jlqV21lfFBCafxAxnT9xPB6EECHHLTf1s9XhfNjQUSKPK7WHxa8v7oS
	 /nPHNSN2mdmk82bRqzL0Ryh7YeIG+ySMd10JLRyqHoH7JSUn9O+sM5xrQ37x6v/wqf
	 7uwFpx5XxbZ9fMwZ3qLieDf/Hfl9Wj5Jdkm9os3g3BDLIpz2AwyUxjaLY3J9+i9s8P
	 jttH3lMXafLww==
From: SeongJae Park <sj@kernel.org>
To: Shu Anzai <shu17az@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mm/damon/tests/core-kunit: verify the 'age' and 'nr_accesses_bp' fields in damon_test_merge_two()
Date: Tue, 23 Dec 2025 21:27:35 -0800
Message-ID: <20251224052736.81694-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224042200.2061847-3-shu17az@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Dec 2025 04:21:57 +0000 Shu Anzai <shu17az@gmail.com> wrote:

> Extend damon_test_merge_two() to verify the 'age' and 
> 'nr_accesses_bp' fields.
> 
> Signed-off-by: Shu Anzai <shu17az@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
