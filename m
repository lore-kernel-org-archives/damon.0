Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67716366821;
	Wed,  4 Feb 2026 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185209; cv=none; b=IDk+a79ZyoPr/i7wvwo+uEnYW2I5WwStcPCPVpn2KjkDC9dirVLW06JlOkBhLhltYVglz3/Y5eXtKK00ZXlbG5mfIfftjuEznso7eAsI/SlghZ99rxbGzZ3Lio8wqZKSMS+npl/dzFtrittLSRE5Y5ZhOWf37u3Jk3haGl49IcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185209; c=relaxed/simple;
	bh=YDx6StxtpDi58Lvtwkex+sore9y1zO7/lL+DfNC6Sq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3Xmv5Tq6prj2QEmYw00gnkhadUi9M2XkRKGvBgPO05rrKomVwwv+WCeTpoHpJeTT6+O6le50wwsPGGs4JNIo6tfj9ohEE0bXLQmx91O3b67UxYWbg0qtgfg49l1pMWm3LVU9pxNQ3scHCFc9IZ+19aBsQIvEVfZkRyoaY3iCgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6pDqTIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6pDqTIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9261C4CEF7;
	Wed,  4 Feb 2026 06:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770185209;
	bh=YDx6StxtpDi58Lvtwkex+sore9y1zO7/lL+DfNC6Sq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6pDqTIfKYSOHU297/fPjNP2NvQ2xMkHZOQq1eSZ1tF7slzQRnBqZSAx9mYGWMNTI
	 aDngLHWLLoiXoqHGUhdRuHyDbRuNrJgxWYqT8TAU4x5KHzX9lYalnmB66IJxPn4QWH
	 K14oTzSPh9cCeq9Yl4j9WgXaUD4G3zC5q0gwicfMNIjWmuW8v9rpHGL0XKeqD+9c9W
	 0HJv99ge8aOev5BnLoYfuzMuj4Z7G5idL05MuBDsByOXgguTSzazN8od7p6lg6+fcQ
	 QVxH6vkHAu+0zW+TsFySilcaTUZMRmRqtf0JyXDeJg/jLhPFAEheKsbVC7RNbdjv+0
	 vJp1A34Yv4nxg==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	kernel_team@skhynix.com,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com
Subject: Re: [RFC PATCH 0/5] mm/damon: Add node_sys_bp quota goal metric for
Date: Tue,  3 Feb 2026 22:06:40 -0800
Message-ID: <20260204060641.97191-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260204022537.814-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  4 Feb 2026 11:25:35 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> On Fri, Jan 23, 2026 at 05:50:43PM -0800, SeongJae Park wrote:
> > Cc-ing SK hynix folks (Honggyu and Yunjeong) for quota auto-tuning behavior
> > confusion (not stop immediately after satisfying the goal) I discuss below.
> > 
> 
> Hi Seonjae, thanks for Cc-ing us :)
> 
> > 
> > Please note that the goal-based quota auto-tuning works in proportional way,
> > preferring small steps and "eventual" goal convergence.  As a result, migration
> > will occur a few more times until it is completely stopped after the goal is
> > satisfied.  Unless there is another scheme that migrates pages into node 0, you
> > may end up having node 0 having a bit less than the 40% memory.
> > 
> > > 
> > >     No oscillation - migration stops when target state is reached.
> > 
> > So, little bit of oscillation could still happen.  Hopefully that shouldn't be
> > significant, though.
> > 
> > IIRC, SK hynix people also confused with the behavior when they experimented
> > migrate_{hot,cold} action with NODE_MEM_USED_BP goal based quota auto-tuning,
> > but using only a single scheme that does migration in a single direction.
> > Because this is at least second time it made confusion, if you need, maybe I
> > can try to add a feature for making DAMOS immediately stops after the goal is
> > satisfied.  Let me know if such new feature can be useful for you.  Cc-ing SK
> > hynix people (Honggyu and Yunjeong) so that they can correct me if my memory is
> > broken, or answer if the new feature I described here can be useful for them.
> > 
> 
> Yes, you're absolutely right. Currently, esz(effective size) starts from 0 and 
> esz gradually increases as `current` approaches `target`.
> Once `current` reaches `target`,  `esz` then begins to decrease.
> 
> However, we observed that even after `current` hits `target`, 
> migration still continues relatively aggressively - because `esz`  remains high, 
> and it takes time for it to decrease.
> 
> To address this, we previously suggested that initializing `esz`  at `target`
> (or something suitably large value, rather than 0) and letting it gradually 
> decrease as `current` gets closer to  `target`.  
> This would allow for stronger migration when `current` is far form `target`, 
> and gradually weaken migration as `current` approaches `target`.
> 
> Such a feature would be useful for us to experiment with tiered memory system :)

Thank you for confirming, Yunjeong.  I now agree this is what really need to be
implemented.  And I agree your suggestion makes sense for the use case.  I want
to take sufficient time for good design of it, though.  I will share update as
soon as I get some idea.


Thanks,
SJ

[...]
