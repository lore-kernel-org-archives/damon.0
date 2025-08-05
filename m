Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A617C21A928
	for <damon@lists.linux.dev>; Tue,  5 Aug 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754416272; cv=none; b=h8M0SmkuoPRDGs9Xd5eHxCLGEEp2CRdUn/44HUdeXVQGJEMI23ngKqbcMEppEOcIim05AYkWv4rlm1KCP4c9HoLCKCqBlVxQK3xpyWHrUeqaaA+rNjmVxGSlPpNAs4H/3HdD6o+VKRwR3HdYdjf/sIPAf0PgWRBOR6y5VQvm6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754416272; c=relaxed/simple;
	bh=8g0UjY8KpgVw7yEBK5CekyrLQKSEymkYbsSM62Ge2DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3LDQCwAoddN2teKvXyQzSpsccCf6XbuU/AiEE4bs32He7JKeHHO+41wD2/gm6ilS1GFu8JnewBN/TLt2YIfwv9A972+U9+1BBlOWAjP2Tihw284me6AQl2RYIfAhDwSWyLSW2/eTJpnzphUbP/MaPP/Kw8XuCsv9WlpDoWalkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bwvefw2Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bwvefw2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2126DC4CEF0;
	Tue,  5 Aug 2025 17:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754416272;
	bh=8g0UjY8KpgVw7yEBK5CekyrLQKSEymkYbsSM62Ge2DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bwvefw2Z7hFwqdVFbx4Q5p+CVqM8sPtQx+3IaD4zueVhRV+Uffjz7GGo8w6id4N64
	 T6v+DumjaMB+jwxeq9fYfGtFWF+Hc3YnZX492TwuqPuHLp3NyUDUY6DLcEam/eg4wW
	 8EClIytdqzE0urb9Kdv7QprtQOwmaOhVXNhUCg4hLTJxDDzFlU98eCu6xBB5mUmk4k
	 ngzVSCgYyMzqT/7bad9+wEW7hI0j0r7i+PBZzJEeDdC7+nufDnqNzM8mqgAvRjC+Nw
	 ZLcosdh+Gv0/v4BexMMOIDuaWgDFWV7FSJfmJ6K03P3eDiUuMAF3r01wVAlhDhUf3J
	 NTF/qN7pCgc5w==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH] mm/damon/vaddr: avoid unnecessary migration between target nodes
Date: Tue,  5 Aug 2025 10:51:10 -0700
Message-Id: <20250805175110.7589-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAC5umyjp_tbcJ3=UdSv0WCiOWytW3arBYp3nwv9i2V24ENmmPw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 6 Aug 2025 01:04:47 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2025年8月5日(火) 1:43 SeongJae Park <sj@kernel.org>:
> >
> > On Mon,  4 Aug 2025 10:19:20 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> >
> > > On Mon, 4 Aug 2025 21:46:49 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > >
> > > > Hi,
> > > >
> > > > 2025年8月4日(月) 3:01 SeongJae Park <sj@kernel.org>:
> > > > >
> > > > > Hello Akinobu,
> > > > >
> > > > > On Sun,  3 Aug 2025 22:00:28 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > > > >
> > > > > > This change avoids unnecessary migration by checking if the folio to which
> > > > > > the migration is applied is already located in one of the target nodes.
[...]
> > Agreed.  If Akinobu's use case is not depend on virtual address space, I think
> > paddr is a feasible direction to go.  Note that 'paddr' doesn't support
> > multiple destination nodes for now, so development of that would be needed if
> > we decide to go in this way.  But, again, I'd love to learn more about
> > Akinobu's use case and the problem first.
> 
> In my use case, a script periodically checks the processes in a cgroup and adds
> new processes to the monitor targets, so the target processes change over time.
> (Processes known to be short-lived or have low memory usage are excluded)

Thank you for sharing this!

I'm curious in more details, though.  Could you share what you want to achieve
with it, what DAMON parameters you are using for that, and how well or bad the
results match with your expectation?

> 
> As you point out, even without the patch I suggested, it seems unlikely that
> continuous migration between target nodes would occur.  The reason I proposed
> this patch is that I didn't want to move any pages that were already located in
> one of the target nodes.
> 
> It's true that paddr is more suitable, so I'd like to evaluate it using paddr
> and compare which one is better.

Soudns good, I'm looking forward to the evaluation results!  Let me know if any
help is needed.

> However, these processes have different
> performance requirements, so vaddr may be a better choice as it may be possible
> to extend special handling depending on the target process.

We have implemented memcg type DAMOS filter[1] for such a case.  You can use
the filter to make a given DAMOS scheme's action be applied to only pages that
owned by specific cgroups or not.

We also recently posted an RFC patch series[2] for memcg-aware auto-tuned
memory tiering.  The RFC patch series is not yet upstreamed since I found no
time to further test it.  It would be helpful if you could test and share the
results.

Again, I'm looking forward to more details of your use case and evaluation
results.  Let me know if there is anything I can help.

[1] https://docs.kernel.org/mm/damon/design.html#filters
[2] https://lore.kernel.org/20250619220023.24023-1-sj@kernel.org


Thanks,
SJ
