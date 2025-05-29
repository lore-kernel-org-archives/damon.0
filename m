Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944751632C8
	for <damon@lists.linux.dev>; Thu, 29 May 2025 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748539610; cv=none; b=Me3r1udGBwhrXUKxS3HeIgHTyrTydNIwDJ2Dg1g2s16LVBlYFffP3rrvaHlY2YG+0hhUPj6pMJ5Phe8M2Et0qaZILjb/7kR5wK8um1B1/1FqY4/dzhVAyVq/wJxEFZKXoshQuqL5nBs2qTnrPdWjk0pERXkyvgqaXchG0mTmLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748539610; c=relaxed/simple;
	bh=7yLKz/b4meB879RSKiPtWuCmuVOR7B78qaTLus9vMVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=estchEzrA8f02KFik4agncjWvLcVDoaXs8qNCXUD1iygNfD8xCtXYWk4LuWlNrecCGbDFpktjE7TuaA0pj1zYNHthtm9xGqLNigeLt/bW+HCJCA1QfckNck0H7EAHuLg1t4J3g1oF87bo1tpWmtBrV+YDRWKLPZ96vtPtGb2oE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM+tmPEM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM+tmPEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E338FC4CEE7;
	Thu, 29 May 2025 17:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748539610;
	bh=7yLKz/b4meB879RSKiPtWuCmuVOR7B78qaTLus9vMVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oM+tmPEMretWTdt2ryz08GuOAraz5FBxoDYZtwHva8DFHXHO0aIRbKZ1V2vuH+LtH
	 XNb4CBMNLnI4WoxMjYmOLHdnC2AWc9E/nXli2FJGbxbs+O38gHuH9SCIkqtfAbVVJV
	 6aSfwhDSFL9eVVeP7cOt79hzXECzXFFnyuqIiq2k3s0Jb42A22MwviUteq+Vqyfuyt
	 A697HbSUobdPWuWutLdJK/UYq6j698+nnpoQSaYp19ddjxC/A9U5GSM0eBtthBdtCU
	 JaR7S3DWRkkf4vSBAm6MOoadFxfQK5AmtAbgUqHMLRyOXf/PQx82+8Cmpxz8A/jnqM
	 /dy+3N7Sjp4ug==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: David Hildenbrand <david@redhat.com>,
	Enze Li <lienze@kylinos.cn>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon: rename primitives to operations
Date: Thu, 29 May 2025 10:26:47 -0700
Message-Id: <20250529172647.38178-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250526175524.2651-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 26 May 2025 10:55:24 -0700 SeongJae Park <sj@kernel.org> wrote:

[...]
> Maybe "mm/damon: s/primitives/code/ on comments" could also be a simple and not
> that bad title?

I understand we found no real concern on this. :)  Thanks to all discussion
participants and their patience.  Of course, just add more comments if you just
forgot posting it and I'm rushing.

Enze, could you please post v3 with the updated title?


Thanks,
SJ

[...]
