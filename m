Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E5287276
	for <damon@lists.linux.dev>; Wed, 17 Dec 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010373; cv=none; b=CMZJBjmcBVUw73gVYRjEfZYnaM1akln0LMTf/36vxnYzIAcHUdIJEZHUdZDvW9xeIQQhTi/87N8iaAjwTwXwLaXyDs9eS0F4lptbmzAuFLAGkfP2KQpQNxbELDofoHha1s/HeO6fqPYH2LIw4pWvGL0YfoprOlhwMxwKmyWJHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010373; c=relaxed/simple;
	bh=aluNDjkycM9nO1EYCcQspfWRtaIHWsQFfrlraFFei8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwQ+OKNwt84C3jerb3t8gEAG3vG7Vt4ZUsZBXCIPs4iEj77AfY6EJ3SVg3VDNEXv7zRifcwtCZnIZxJLmVgJR749SnsHIwBihURdmp3NsRj2fiqAdrogsb4Nvn0aKxMx4Ze0Gk2wkp/Kj/yff3/93tQvS4ocvsjRA0NK4vFEjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkLPimxF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkLPimxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC4AC4CEF5;
	Wed, 17 Dec 2025 22:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766010373;
	bh=aluNDjkycM9nO1EYCcQspfWRtaIHWsQFfrlraFFei8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fkLPimxFNArqio1f/gKJhRA1u2EDDZP1m9gFXxIOFbtZVTIuKahcueBoNOBiBKXhQ
	 mFo0j6gqzaBYqIvKqV92UlrsZfN/aN75k/itnh25fep/X0/+OGgsgSlG4AUP/VNzz8
	 Vo+yeQjJvfwVgKHirR/O1qt+PSdmQ57VSK8l3t8r7Oq9MwDPkHos4PDpk2q2sNyfqF
	 tLxDWqK6pyh9HezIeNilSYJ0mjL98FA9e0N938v5a+Aj36YpRyRw8z0yaeCCiRLg/R
	 xdyBQE5UmG0OzWwzGp60XxzmPmb0npcw8ZkRUhsQalB6dSURsjZ3HVzyWgM9NG3gFL
	 oVO0Vvniw4Xdg==
From: SeongJae Park <sj@kernel.org>
To: klourencodev@gmail.com
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kevin <kevin@desktop-mu90jgd.home>
Subject: Re: [PATCH] mm/damon: fix typos in comments
Date: Wed, 17 Dec 2025 14:26:09 -0800
Message-ID: <20251217222609.3355-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217181216.47576-1-klourencodev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Dec 2025 19:12:16 +0100 klourencodev@gmail.com wrote:

> From: kevin <kevin@desktop-mu90jgd.home>

I think this should match with 'Signed-off-by:' tag below?

> 
> Correct minor spelling mistakes in several files under mm/damon.
> No functional changes.

Thank you for catching this!

> 
> Signed-off-by: Kevin Lourenco <klourencodev@gmail.com>

Other than the inconsistency between the author and the Signed-off-by,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
