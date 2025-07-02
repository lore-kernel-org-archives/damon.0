Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E2310F2;
	Wed,  2 Jul 2025 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433827; cv=none; b=Aoi0XbJdZriu3lOvuWDz+/n08wocz/71p7KGGiC79Z5m+9GMZ3vb0qh1QnwPq/uqhDnOAImK/fI07FxXgmZZ7kRWMuvrq4HhHW6kKmirDmSFvPY9E8JqljjyL0+6U2AwLNUi+C3rWNDKSjAdv5CxsyBZVygaIFSNdZJWCaW2woU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433827; c=relaxed/simple;
	bh=y61RM2CZLTlPVFVJqIH6LbDQqTpJ/f7eA4CyIMT9MBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBvnoam42eIetxiQ1rumahTFjGK3B6Uv0U95xzOCc+RHEL5+gPOVaR39VM5ULpD6+t9tUlmOAW90FLcKjo2d2xgTmCQhBvjGhiacoebPY15FRbqOFJ33gy2dTEeXENhHIe3GddqHofyLmw9rhnO8qKpZPu6XVQm5Gkm2YCF0cS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD5rO6Fg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD5rO6Fg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1987C4CEEE;
	Wed,  2 Jul 2025 05:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751433825;
	bh=y61RM2CZLTlPVFVJqIH6LbDQqTpJ/f7eA4CyIMT9MBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kD5rO6Fgl5n5OQ70/HCQbU58LVDC5YmnhjnsHg/wWrDItFOo/cqp4zKYOEYcWfiZ4
	 Q1yWAz/ffQ4azvj+4+P3/A78FqV6daelnWyHc2EYYlP1DJUeMrRHXqgWsgLFcAnNKY
	 dTHQ19lFeGS2p6fCKJDFefLaLG9LwnmMJ+lS1GK4TwtwwkXAHh3mD5Z29WG4XdunEn
	 VTEzVzf1ApQqAcXt+Pm1MDwLVvoOhQn0KPI7hrJAGHRHAgvcRu6j81S316EM/X/BSV
	 Hfjt7D1aldbQtcCTSeIeNgHuqJTPAK6Wt21+lP/BPbiJkeQTSY+pXDQSbBuAH7kTrs
	 XXslgqmaIfC+A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Bijan Tabatabai <bijan311@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] mm/damon: add DAMOS_MIGRATE_{HOT,COLD} destination nodes and weights
Date: Tue,  1 Jul 2025 22:23:41 -0700
Message-Id: <20250702052341.54336-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702002316.1139-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Jul 2025 17:23:16 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue,  1 Jul 2025 17:39:37 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> 
> > On Sat, 21 Jun 2025 10:31:27 -0700 SeongJae Park <sj@kernel.org> wrote:
[...]
> > I am finishing up V3 of the interleave patchset using these patches. It
> > has mostly worked great, but I noticed that damos->migrate_dest was not
> > being updated in damos_commit(), so new weights would not be applied. This
> > meant that you could not update the interleave weights by committing the
> > damon state. I also saw that damos->target_nid was also not being updated
> > here. I will will have a patch fixing
> 
> Nice catch, thank you for finding the bug and making the fix!
> 
> > this with the V3 of the interleave
> > patchset that I will hopefully send out tomorrow.
> 
> I cannot wait, but please take your time! :)

I just realized this series is missing documentation updates.  So I just
posted[1] RFC v2 of this series with two documentation update patches and
trivial commit messages wordsmithing.  Note that other parts are same to RFC
v1, including the damos_commit() bug and damos_migrate_dest name.

Please pick the version to your v3 of interleave patch series if possible.

[1] https://lore.kernel.org/20250702051558.54138-1-sj@kernel.org


Thanks,
SJ

[...]
