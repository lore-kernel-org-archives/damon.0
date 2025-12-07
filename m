Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE442050
	for <damon@lists.linux.dev>; Sun,  7 Dec 2025 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765074990; cv=none; b=Ej3uvM9LboBcGi0R5K7vbzMTUOUTSC1n13FQ+GWJh8wG8Vu2cID0w0p4aKRIaU2A5rDi/HDnZOPCe75mg1myZOw9mdon+LZXDjwInQ5xfmz1ToghpuqH6HE3V15d895gQ/eWb/cQ794oLmyoPNd+lUyroi1VZ477U1Llf0FdULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765074990; c=relaxed/simple;
	bh=CtJt8Aaak1dMFe8w2iMKtDuXgkibMZoukhc8PNi8Krg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbVDKAAiQ9Rx7eQb3eeb8VRRyjDRD75U7WqwqzwOz7RwW2IxYtP0uV8KlM4JANodMgHCic5v/bi6YBnR/eJBSs1wUc6q0CuOu1KDWYXjm/zsEmtUzD5cUxmqwHZB3PjWYhLXpXH9SwEQQ1IaIfVgJdvW799ol4wPO3nmvzHQ6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPZilZEW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPZilZEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071CBC4CEF5;
	Sun,  7 Dec 2025 02:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765074989;
	bh=CtJt8Aaak1dMFe8w2iMKtDuXgkibMZoukhc8PNi8Krg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPZilZEW6kw0uc+bGl3VHAfRudFGSxArS56f3F+c724FJtz9dGsNHvuWF6iQj/3jh
	 PrylN9D+kGXSDYDjPAJ+sM9gQGr6gD1mB3v3ur/K6PFrFvu3/eaebZQA1+WKf2WIO3
	 KqV0mS/QVe2Hm/YrdbeU9OMvSPsJUV3wSL+4H5ohRdTox27k+ANaYtufuE6sELY243
	 FQyFpfj+AU3dOkk6DnfoCxEXZx+lnz/LOCwOxlpCFxstUM1B8wenYybTlE6oEf+GOU
	 GgjBoi/qJkRiXeTQZzhsU2kw5fZQCCUlvLI4xWgIJ9ChaHAOkHAMInt97+xZ7bR83r
	 IvujCeenSpICQ==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: modified damon_call_control from static to kmalloc
Date: Sat,  6 Dec 2025 18:36:24 -0800
Message-ID: <20251207023625.44177-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251206224724.13832-1-rgbi3307@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  7 Dec 2025 07:47:23 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> The damon_call_control structure is used by all damon modules.
> In mm/damon/sysfs.c, it is dynamically allocated with kmalloc(),

It is only for refresh_ms handling damon_call_control.
damon_sysfs_damon_call() doesn't use kmalloc().

> and in
> the remaining modules, it is statically coded.

I try not to use dynamic allocation when possible and *reasonable*, since doing
so eliminates the chances of bugs from dynamic allocation handling mistakes.

> There are many daemon
> modules and they are designed to be used only when needed.  It is more
> efficient to use kmalloc dynamically whenever needed as in damon/sysfs.c.

I agree that is more efficient in terms of kernel size.  Nevertheless, I don't
think it is a significant improvement, since it is only single data structure
per the DAMON module.  The total number of DAMON modules is only five.  Two
among those are samples.

> Using damon_call_control dynamically and consistently has the advantage of
> eliminating the dealloc_on_cancel member variable condition and reducing
> code size.

Disadvantage of this change is that it is adding four more dynamic allocations
that we need to cautiously maintain.  It is not significantly increasing the
maintenance overhead.  But, the advantage (kernel size reduction) also seems
only modest, if I'm not wrong.

So I'm sadly have to say I don't think this change is really needed.

Please let me know if I'm missing something, though.


Thanks,
SJ

[...]
