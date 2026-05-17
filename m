Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DED3CFF66
	for <damon@lists.linux.dev>; Sun, 17 May 2026 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043719; cv=none; b=Yui+FnlZ7zVssOD9SVUJNkNfHUJvMGls5m2SLB2qloMdBTRaVuxhkDp9mAaRNgzoRdvXLMwYWGRDhrgzOTlRY+8afqZ4Wz8KR/C5hcM7vVDmco9KJ6Q+dwubw7w2ojmxDNOPya6GF2kLEwcmkkCRVIc9+JTyEzKurne/wG5LPYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043719; c=relaxed/simple;
	bh=aN4lJD9FqdIhEZTgeArPv1vapcSuNNQ/Y0JvhOflDSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVVew39pQbPHvp+3Ycsb37OzhEi6pxPLbqyEHiYNTyrSQPXsOBY7HCk06JwkmoRhypKGhKaM369nI0oSASwRxw5b/o/KxF93JeHZZzV3EheK7IKko1BgfAwVExHdC1hgaPkLYvVLdEhf9Ck6vhXioymwppxVxY3Y05WGXu1jsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8BbgXEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8BbgXEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9D5C2BCB0;
	Sun, 17 May 2026 18:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779043718;
	bh=aN4lJD9FqdIhEZTgeArPv1vapcSuNNQ/Y0JvhOflDSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8BbgXEFRRv5/yYYGeZ8ja3TeydZiByzVxYEl/W4C69Afn7PnVMmZD+bgraZQzQTw
	 QDV4ZzaJey28E2GuXeKz7iB4qFRYAm2yq3jOg7kO2PcaO9FARn1YI593g4XBSXSGMw
	 wtjyQcKpA5vqeQpJbW5kPt+rdoo2mUesPq2h+XTqfBLe2P8FjaHYcgw57F6WO2+k5Z
	 X0vC1t39wtTw4Leutbrlloev8qDA3n7hrRG72McKVd1B5W7OBNp5LUqMj78eXEe7mS
	 Zl+nJ0GE5znm9JNd0E3tq8PUfCst9ZPPwhqfYN3vVQKloPo+bIrta2mK069ZgnBwnU
	 SEac5Uz9IqMYw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Ravi Jonnalagadda" <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/5] mm/damon/core: cap effective quota size to total monitored memory
Date: Sun, 17 May 2026 11:48:29 -0700
Message-ID: <20260517184829.4769-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516225528.BAF04C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 22:55:28 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] The safety cap limits the effective quota output (`esz`), but fails to cap the tuner's internal state (`quota->esz_bp`), leading to severe integral windup.
> - [High] Accumulating the total monitored size into an `unsigned long` overflows on 32-bit architectures, permanently crippling the scheme quota.
> - [High] Applying the safety cap can forcefully reduce the effective quota below `min_region_sz`, resulting in permanent scheme starvation for small targets.
> - [Medium] The safety cap is completely bypassed for statically sized quotas due to an early return, causing inconsistent API behavior.

I have a high level question that I replied to the patch.  I will look into
this kind of deep details after resolving the high level discussion first.


Thanks,
SJ

[...]
