Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A7325716
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 03:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776225216; cv=none; b=aaM4MeDeHk9IfS42mF0wDuCiGqSnG7LXOwZgLqQJ8W81IAimxoZghwJyBpv2iaxPUNFOy1w0suLPycQ+df4sdJJfJDqbWDv7Fu046c0NKlIWhJFponu47mbo1R7wLi2T0JnlTaTvZ23ml5UvhYKZ4UJk15QNsyWaL2Nf7Uc3vQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776225216; c=relaxed/simple;
	bh=oXGMNTw1rI00zGApeBhWZK14rjz5xbmHH+nSCODlXAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkOnwwMQky5l893dEUomr/wWYSosBGe4gfVRJHVB6l0G9Zf7ssgO4neVeWZEbdQtlGil4SZ9pZdM2mxB7yXunkt+6zA4R44nGLhTL7fCbH7hMM0X8WCyhtHYPuSxs72CEa6rwNLRUpKGVgOWVHTnA4nFc6mevJ+iNDcLS/JgPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO0mgte1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO0mgte1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4F5C2BCB3;
	Wed, 15 Apr 2026 03:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776225216;
	bh=oXGMNTw1rI00zGApeBhWZK14rjz5xbmHH+nSCODlXAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aO0mgte1BSj0tipzVIampZ5frPfkehQMet0XAu1Ak6QaIOzj6+G0SMfW06a96C/Nr
	 d311QDXsXlU3+BtzRmJC0obiA0GGnO+KnghAVn2xPdm8JghRwFQjD/pYCbQa05c3Wt
	 Nxt4pbrG4QcMN0sAE8U4fIe4KjnHHaaIzeT4rHeBGdDhI0UIjt/ZKD5oy41k/ytSjc
	 06p+/UagEU8KH/JcrLZuAi5KLnVQkz2exv9mCNQKA+ibyhTv+j/Cx/yN9Of9V4u9zt
	 06pw/V8SaPHdRBBX9g/7VC2CiiLxNUFSYw6EP850dO3qC9ZI7K/mayyH3JNfX8ZSzx
	 FnWf0FaJKzcEA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 7/7] Docs/admin-guide/mm/damon/lru_sort: update for entire memory monitoring
Date: Tue, 14 Apr 2026 20:53:27 -0700
Message-ID: <20260415035327.83451-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415025740.F0373C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Apr 2026 02:57:40 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [Low] Typo in documentation update for `monitor_region_start`: 'phyiscal' instead of 'physical'.

Good eye.  I will fix this in the next revision.


Thanks,
SJ

[...]
