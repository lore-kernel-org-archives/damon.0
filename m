Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373D245AF8
	for <damon@lists.linux.dev>; Thu, 13 Feb 2025 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485386; cv=none; b=czGu2BYMpN0BXO1NbvUatbyiJAN8n6BmIpxN20wGWLtNVd1E3M7vtEuCMzgwucIyzNqjgERQn6qmRgZQhsRaYxc0t1g/QeluIcfJxSIUmL/OsZPgIZtGQbv5GaYskd64kfjpw/1d2xbbYvldfZoS0547pJCAL+lXxWSKwiGXLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485386; c=relaxed/simple;
	bh=Jtl+q3aMpDMqMp4GGcF9IzcDFQMJJzUJ30zZ0gQeu9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O8XihQgxpL4isFa9y7bix1XKKmZlGL/GbSffoEKPLOKI7JEtsfT91h6uZ1aah1xMSDj3oQbq44b0pJ20+vQo4+bIlSSM869osETi9T9r0e0CNHGYkkeweNhruTJJzfcVXbgJ8hfa+zZOumdLaZdUW8c3tY9FSX1YcZEuCOe4C9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgEL4BKt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgEL4BKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5758C4CED1;
	Thu, 13 Feb 2025 22:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739485386;
	bh=Jtl+q3aMpDMqMp4GGcF9IzcDFQMJJzUJ30zZ0gQeu9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DgEL4BKt+ow83TvsEVt5yXwynKsdCrZUCn811o5an3zZDmOfnx8pM9KNPpfi1Hu7k
	 47aqEuItSC7ztPxeuBu+qxAcq3/YfM+pyD76ioAJkQLmtAWllfmMh+ML678nvCcGfn
	 8f0C8pgidzifqAGIze24uaDtEg+sPGhX4u+pnCxbRgv7/URs+77ZBe8gd/yO0G6QvD
	 u8BxCdMkfokb79gYpF8yKysIFklFsgvKqNxEWdsJu1RJMW3mdwE2RfWRH9WEUll0LY
	 eVnw464WZSkmAkst+QdmbkIL6EkR6Q5op4guOK99vtcRer9XhHmcTP/KxWLCllygrD
	 rZCMdAK2ZYuwQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: Two simple ideas for DAMON accuracy improvement
Date: Thu, 13 Feb 2025 14:23:03 -0800
Message-Id: <20250213222303.244724-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241026215311.148363-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 26 Oct 2024 14:53:11 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello DAMON community,
> 
> 
> There were a number of grateful questions, concerns, and improvement ideas
> around monitoring output accuracy of DAMON.  I always admitted the fact that
> DAMON has many rooms for improvement, but was bit awary at changes for some
> reasons.  Now I think it caused some unnecessarily long delay.  Sorry about
> that.  Now I want to invest some time on the topic.  So starting by sharing
> below two simple ideas first.
[...]
> 
> Periodic Fine-grain Split of Aged Regions
> -----------------------------------------
> 
> If a region is continuously changing its boundary and access temperature, it
> means it is converging, or the access pattern of the workload is not
> stabilized.  Either case, this is a healthy signal.
> 
> If a region is consistently showing same access pattern for long time, it may
> because the access pattern is stabilized, and the region is correctly
> converged.  However, it might be because the access pattern is changed, but the
> converging is slow.
> 
> To avoid the too slow converging of aged regions, we will let users
> periodically increase the split factor for regions that kept current access
> pattern for long time (high 'age').  Users will be able to set the 'age'
> offset, the split factor for the aged regions, and time interval between the
> periodic fine-grain split of the regions.  For example, users can ask DAMON to
> "split regions keeping current access pattern for ten minutes or higher to five
> sub-regions every minute".

This means that users need to answer three questions.  1) How frequently, 2)
for how long regions, and 3) into how many sub-regions the splitting should be
done.  It seems too dificult to answer.  To make it simpler to answer, and
still preserve the effect of the original idea, I'd like to adjust the idea as:
"Periodically split regions without limiting number of resulting sub-regions
per region, while keeping the aimed number of total regions after the split."
For example, if there are three regions of different sizes, slice any region
any number of times if it results in making the total number of regions six.
Where to slice will be random, but would be uniformly distributed in a large
scale, to avoid too much bias.  Having the distance between the slicing lines
same and randomize only first line's position can be a simplest implementation.

The updated scheme asks users only how frequently the new split method needs to
be used, so reducing the number of questions from three to one.  Obviously one
question is easier to answer than three questions.

Huge regions will be splitted finer than now, so what we wanted to achieve with
the original version of this idea is still kept.  Unlike the original version
of this idea, it will do the fine splitting for even young huge regions.  But
the unnecessary splits will be reverted with upcoming regions merging.  Samll
regions may not be splitted with the new approach, and it can slow down
converging small regions.  But the next split operation will do the per-region
split, and user can set the frequency of the new split method.

This will make micro-target region split difficult.  But such micro-targetting
is anyway challenging for users.  If they really know the answers, they can
reform regions as they want by online-committing of target regions.

Please let me know if you have any concern or question about this updated idea.


Thanks,
SJ

[...]
