Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322336EAA7;
	Mon, 29 Jun 2026 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739493; cv=none; b=dY61vJcOsdr4zo1Debvototb5hFuzr6/CJnUaRsjY1otK5EDzMY5LktGGAQ5v/Sy4fvtODvYKuvRcZslobhQG698gMF0V53uDxiFIHWxefVm2uFQYpMdojo3VgZv4sDAXuQCJZm6mHEnsmZSCpnfCd7GNd/cVHIoy98+BxkFJXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739493; c=relaxed/simple;
	bh=gVeYLlhXOHPQWF7Gt8+3KPXjj5tpokMWzpGoYGhaPEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIGwC/lGMjerNuUpBHk83nYW+HeXA45ndTjhLKsS/Wg2j7J0FvS0h/wNayWkl1uVS/lcLIjWKtXi29uqjxqbLuYJiVCKstpCczWjDH3w76YFEt74QGue3NV7oWBe/EVfQX9c/JnZGFW43cc77LoPPnl3FKtFjhcbOfcEXNDqcoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McCDVAlg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McCDVAlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1DE1F000E9;
	Mon, 29 Jun 2026 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782739492;
	bh=HOUoznpXkigmh8oYSHGFoXWsuDrCze7tnG/NPKBj+kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=McCDVAlgNmf7hxH7+bscDwPdkzmimscS8MZcUXGzbNACev9Cbl3/Gt9n76Loyme7F
	 F9wUCbQhG+nVhWV5Ql/rgHXwXLXV/9VyiaGG/EaWBjxU2bAxDmZpHm88v6YFe6VAf/
	 QjL4XpEKAOXjFB4TgArmSN/Ado46MJHFKNF9J1ACGdm2d3rZRAuUP5QsFx6p72psSs
	 1q+34rIl9DucWrn+soFGmXkJYH2WrlXVPo3I1DkNW/iW22L76x+NthU9H4lYFo6LpR
	 9mCsw+SAWrkLKblgk3xNkOPA40CvzUaJfSYgT6HyMpl/YV44A8zs3S24rmLzFezFGq
	 tDn4dutzhZWBQ==
From: SJ Park <sj@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: s/SeongJae/SJ/
Date: Mon, 29 Jun 2026 06:24:43 -0700
Message-ID: <20260629132444.159703-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <akI8_W0mnQHhXS20@lucifer>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 10:38:31 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> On Sat, Jun 27, 2026 at 12:56:29PM -0700, SJ Park wrote:
> > My legal name and preferred first names are SeongJae and SJ,
> > respectively.  I was using the legal name for commits and tags, while
> > using the preferred name for conversations.  It sometimes confuses
> > people including myself.  Consistently use the preferred name.
> >
> > Signed-off-by: SJ Park <sj@kernel.org>
> 
> Same comment as David, but in general LGTM :) so:
> 
> Acked-by: Lorenzo Stoakes <ljs@kernel.org>

Thank you!  I will send v2 with the clarification of the removal of copyright
notes, and your kind A-b: tag.


Thanks,
SJ

[...]
