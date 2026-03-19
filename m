Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40123E3D84;
	Thu, 19 Mar 2026 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933876; cv=none; b=ualyHORgQ5+vqxQ+NsoSnmgzT86aaR6LVI7RMM3AOjX/NamGGAYE8aIxFtB9Pd1oEjF6z9ytNCSkom5Y6r/+2Z/hZ7EUOn/4ZGMDWk28Byo7Wwan/bj1OuYz/o1lAO4j5TBWU69z3c5POBg/uca8uiV7WKOhxl/Qb6nwJI5GU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933876; c=relaxed/simple;
	bh=BE3MW6vNPVQLiU+P8M5EPT5GuRJwZVTSshCwMY3wHEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0eNKi5KJIfwbwv5xEOhzWTK0+THYPkkqynWwP6Qiqly5+TmPD0P474PoNcDNVX5Pdu6wm47Dz01ixWBNSbMvzVNeujguI2oIio4TWnzx/a2NGcDfg0Ftbfhx50F4pTziWKShr2UjM4Nez+dTHAvLOcsmnEOWLq09v0Flp6HX9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhKcwaPV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhKcwaPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A8AC19425;
	Thu, 19 Mar 2026 15:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773933876;
	bh=BE3MW6vNPVQLiU+P8M5EPT5GuRJwZVTSshCwMY3wHEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhKcwaPVIMuH6l6y9bnIwW0oOwVmDqe+JufXrEvCIyenFRkw8aci4WNYlazlnqwyt
	 arjNCVPOLJYkFMW/KbH3m6zfIILgWe5gN5THHJ+bCbJ3RH0DOwCugOWDpZUI96iqOk
	 C0kw7RgiPJCRHfcxuHx8oft819fnG2kAZIKxamMMTW+x0kd4WyDaY9CM6D3cGf4ot6
	 RtfDAEL3R+C3o9FO6nv/jMsde0yFmJb7tGQhDE11SEb2ownvZo2YOp/bpINVLM4yMZ
	 PEI+GSyMCLcnTJ2+3QDuR7/FUAY6V3gf8eosYvKPHQ6G3v9X2M2oNrx6Kn2cs8cKoy
	 L8qj1tfN2mdgA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Josh Law <objecting@objecting.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: document damos_commit_dests() failure semantics
Date: Thu, 19 Mar 2026 08:24:33 -0700
Message-ID: <20260319152434.87003-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319143116.82849-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 07:31:14 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello Josh,
> 
> On Thu, 19 Mar 2026 07:13:32 +0000 Josh Law <objecting@objecting.org> wrote:
[...] 
> And Sashiko comment [2].  TL; DR: Good finding.  We aware the issue and working
> on the fix.  Nonetheless, that's out of the scope of this patch.
> 
> : Does leaving dst in a torn-down state cause a NULL pointer dereference in
> : the background kdamond thread?
[...]
> Nice catch.  We actually figured out [3] this issue from the discussion on
> Josh's previous patch that motivated this one.  And I'm working on it.

I just posted the patch:
https://lore.kernel.org/20260319145218.86197-1-sj@kernel.org


Thanks,
SJ

[...]
