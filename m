Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3E26B777
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782074555; cv=none; b=NZnxn8paJkBHArDWp1IEsXYhY5O71uIPeewoUxHVeB19i+q7cB4hz4m7JVxBoJ8STYX0s5hGrPktiYdI/aMo2lu8XJq0eadVZTaloiP+HX+kjo81ju1TDgjQRbOlIQRkdSwArTRQm/dETrbRnWCGIbSIY634LWwj4sSBM53CZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782074555; c=relaxed/simple;
	bh=OPQ4+nx5uk0fMLb+gZTBbpDrkU0zoD1Lt6beBOUWcSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnByxtWfLXYya0W+79miadUhLBj0M8k6JTO/yzVOpaYoLdXlsQ3fu0qb9dvolPUZQNIM+VMMEN8Lp3YsH0FJqHIzSNDoFSAfQMxZwP8ym2vlYcFWyJvKdE72MC/JBHANsm5Ry78dHas69HcO1I8SdmecEMReYXl7a/DBCpe9jXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7VNUmBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7VNUmBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A661F000E9;
	Sun, 21 Jun 2026 20:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782074554;
	bh=yY3b2eChyaTkxEi4Eyx62nKY2jf6nAkDbvkFnrtpuLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c7VNUmBzvnn2w9T/+ZJHCIzKotOYecZVyAQ9inZGG8uUpVWyQ6FL+oTS1DlMgVQdK
	 qzrz+HD0kih++f1ZITjQfs3uR88/qvtDV4maP2nFHZUqEkd9Qx6lmdJJA4+ynY6Qs7
	 amQEWkSA3rS4l8zLPO7chP9XC3I4RGJXnU5KqXk+LHaO4gK0cBlFKewAiEUTzF4JW3
	 Dt90NTS251ms+B/xZAnbbA6YliSqe63VdgmpiBL2k9DJJK4zCHGd2o4EOLEActKmMa
	 i/tjAHz+HxNOofIGhksce6G72GUUhIovwGRqg9EF+7uSqbmLH9o9V4dfsuPDuoFGel
	 62zHy+VcT/rvg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 14/17] mm/damonn/paddr: remove attrs param from __damon_pa_check_access()
Date: Sun, 21 Jun 2026 13:42:29 -0700
Message-ID: <20260621204230.11117-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621160741.BB95C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 21 Jun 2026 16:07:41 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Data race on static variables across multiple kdamond threads.

I'll separately work on this.


Thanks,
SJ

[...]
