Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3751F91D6;
	Mon, 16 Feb 2026 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771278436; cv=none; b=b/kffEG9tHmKI13jUTakyWCIbrCEZk7lOtNFtxYD02I4PnTOdL8HQy66WTSs0QPydkTLSABhk/X5TAYUfbwCpFmEgioGaGgiAuSlD6TWFdTLU8uvXObFmAm9oavDugWLPb9PJbnWvvqyP9VRKVwOB+QQgJZOSfO1G46Ls80FdKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771278436; c=relaxed/simple;
	bh=wZmeRByRpbHTNtIWpUSkmnwjt2QkNJEcQc0HK71ZMGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql/zKCEHOyrvO5RwXFWdCPI5Ep5N2iBtSZr0/iO0Q72Jo9gUfCrWBr7uc8tIvcaXfzQSwFCAoXzu2ilKmstoNN0PWYerS773vW5eOCLjk1oA/WL4K18jYjvu1p9NRHVXY3PGD6SpiXZGF6FnhZ7jgMjRArnxwELkITUEWOtG1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh1tidSW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh1tidSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA453C19424;
	Mon, 16 Feb 2026 21:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771278436;
	bh=wZmeRByRpbHTNtIWpUSkmnwjt2QkNJEcQc0HK71ZMGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eh1tidSWKRQ7DZ3Gm42b0ZHMJhwgc7bYz/NsatZTnTqrxD9b5ofGy3OhEpQIjFK8O
	 /Vy9sKP7AC7Dm9CzbVNaCijAELYpJjMoUqxIbk0JLrEcWrzx9i2PbXAimFAfRkhQrX
	 vnaLUKmw3+I7mvDpA2McDtxrCEexhK384eX+aB8XUfImN6+xMOPCFgMGrUdUb3IP2z
	 mv7cxFt6T4fK2UTskhF293WHpFHW7W46ZLd1ULz/7L/WdOMJk4Dvjep3tOxBxAT+pD
	 bh0uUyiDZV+oNnz3LjZ0YhIwUGxeztnvXmOUo8lVrSNGcd5Q5a65155yoKCfig1BhB
	 lmiJgXKRH3UIA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"security@kernel.org" <security@kernel.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm/damon/core: dangling walk_control pointer in damos_walk() on inactive context
Date: Mon, 16 Feb 2026 13:47:12 -0800
Message-ID: <20260216214712.68725-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260216185741.74145-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 16 Feb 2026 10:57:40 -0800 SeongJae Park <sj@kernel.org> wrote:

> 
> Hello Raul,
[...]
> 
> I also found 'git am' of this patch is not cleanly working on mm-new.  Please
> consider using mm-new as the baseline [2] next time.
> 
> To ensure this is not forgotten and merged into the mainline, I added this
> patch to my tree,

I forgot adding a link to it, sorry.  It is [3] on my original mail.

> after manually rebasing on mm-new, adding a note about the
> user impact, and adding the above tags that I offered.  Unless I find something
> on this patch needs to be changed, and you mind, I will post it again after the
> current merge window, to make sure it goes to the mainline.  So no additional
> work from your side is required.
> 
> Nonetheless, if you prefer to make a new revision of this patch and repost on
> your own, please do so.
> 
> [1] https://lore.kernel.org/CPUPR80MB8171025468965E583EF2490F956CA@CPUPR80MB8171.lamprd80.prod.outlook.com
> [2] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/sj/damon-hack.git/tree/patches/next/mm-damon-core-clear-walk_control-on-inactive-context.patch?id=398e6f536b37de82f789d74ea93815dfcb129d99

^^^ This one.


Thanks,
SJ

[...]
