Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0CE386557;
	Mon, 25 May 2026 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727087; cv=none; b=BYLuWD/6Mgs4I1iOo9je+ax28yWOvmuOhEo1RGHK/ljtKxKhiuCWLcErmwLlIMrffsRlvzk4sVcHkEzPGkK9y5JvU9HGXShW8eUzBvYIH4tj/fmDRrMeEfZ+20wqz9fOTbftpiW+VboyZwHISpaUyTVJZFT6xcCpxrdmupfAh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727087; c=relaxed/simple;
	bh=mNYDnJRsQei1JFmMRGhg9TEdOq/sijoYRD6l8Ki4hqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDW6HuIhcUmK4ZfEXcL4U6nWoPDI/pidXMVuZ0K59lHSgR2iMmwBeD9KD7QHukgCuyP9jnUFP/AcfGs5WrpPCH8KCKtE1A0yeUGANE+qsqxCpalR1kZP/S0WWNxrYovanHXcAieq59AtcpYn2OtZUXLPAI6Pt0u6G8qj9CCGrKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faQpIRSx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faQpIRSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4461F000E9;
	Mon, 25 May 2026 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727085;
	bh=Q5U54gS45JuVd2BwEnLbeDvEWQ/J9bpKUA7tXloYeaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=faQpIRSxTi5bRAhXgEFBkSGcCpMWmoEBQs3V+kx85/StV2fFbEp+jG3cmfppSnCPO
	 wiJDLxDLp7tie7/z5tNc2xuSfsVnKNn+z5VoegRJ1mNo0/YY//ayiIDiAMZU9vX76k
	 sytkrbIqHzhiENqIGnkBURa0qlkEsRe2oXEK/VzXyJL5Ud5w+GQgpQBNT9FIrdDxZI
	 Tgecy2eUp9mN58jnbzLIq3M1lXFoIvt2md9QOyevvLgGuceeJUNJaa1IEVr7Oexwiu
	 qc+9me8FnL4jWSf2hlJXUTOBv1wqF/Ozei2UcipFUy9c2PUx4xSkNh7mE7RxV/8hKa
	 RbKWPmi9Z27ug==
From: SeongJae Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/damon/core: detect internal variation above max_nr_regions/2
Date: Mon, 25 May 2026 09:38:00 -0700
Message-ID: <20260525163802.8667-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9cc396ae-da42-48ad-97d7-213208884ee5@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 25 May 2026 16:09:42 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> 
> On 5/23/26 9:43 AM, SeongJae Park wrote:
> > On Fri, 22 May 2026 23:11:47 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> >
> >> Hi, SJ
> >>
> >> On 5/22/26 10:42 AM, SeongJae Park wrote:
> >>> On Thu, 21 May 2026 23:07:11 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> >>>
> >>>> Hi SJ,
> >>>>
> >>>> Thanks for taking a look.  Quick replies inline.
> >>>>
> >>>>
> >>>> On 5/21/26 10:30 PM, SeongJae Park wrote:
> >>>>> Hello Jiayuan,
> >>>>>
> >>>>> On Thu, 21 May 2026 12:52:22 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> > [...]
> >>>> counter was just for convenience -- easier to cat a sysfs file than to wire
> >>>>
> >>>> up tracing.  Even the tracepoint covers it, It's cost to much for
> >>>> Grafana to just get
> >>>>
> >>>> a metrics by tracepoint.
> > Out of the scope of this patch series, but I'm interested in how you connect
> > DAMON outputs to Grafana.  I believe that could be useful for many people who
> > willing to get some fleet wide access pattern.  Maybe worthy to present to
> > wider audiences, like System monitoring microconf [1] at LPC?
> 
> Honestly it's nothing fancy -- we just export nr_regions as a Prometheus 
> metric because it's a
> 
> performance-relevant signal.
> 
> 
> Vsualizing access patterns is a real pain point.  I have a small 
> AI-written script that pulls region
> 
> data and turns it into a webpage I can open in the browser.  It's not 
> live like Grafana -- I just run it when I
> 
> want to look at the data.  I don't think Grafana has a component for 
> this kind of view anyway.

I agree it is difficult.  So, you are using DAMON for not data access pattern
obserrvability but access-aware system operations like proactive reclaim of
cold pages?

For Grafana integration, I'm trying to use idle time percentiels as the "format
for fleet-wide aggregation".  My previous talk [1] at LPC may give you more
details if you are interested in.

[...]
> > So I was thinking below as a suggestion.
> >
> > The basic idea is, choosing the number of regions to split based on the
> > remaining budget (max_nr_regions - nr_regions).  I'd prefer making this simple
> > and lightweight.  So suggesting something like below.
> >
> > void kdamond_split_regions()
> > {
> > 	static unsigned char rndseed;
> >
> > 	budget = max_nr_regions - current_nr_regions()
> > 	if (budget > max_nr_regions / 2)
> > 		split_step = 1
> > 	elif (budget > max_nr_regions / 3)
> > 		split_step = 2
> > 	...
> >
> > 	idx = rndseed++ % split_step;
> > 	for (; idx < current_nr_regions(), idx += split_step)
> > 		split_region(nth_region(idx));
> > }
> >
> > I think this might be similar to your downstream change, but what do you think,
> > Jiayuan?
> 
> 
> Yes, this is close to what we do downstream.  Roughly:
> 
>    void kdamond_split_regions()
>    {
>        budget = max_nr_regions - current_nr_regions()
>        if (budget == 0)
>            return
> 
>        split_step = current_nr_regions() / budget
> 
>        for_each_region(r)
>            if (get_random_u32_below(split_step) == 0)
>                split_region(r)
>    }
> 
> And I like your version better -- the step formula (max/budget) leaves
> a margin so it approaches max more smoothly. I'll try your approach first
> 
> and test it in our env.

Sounds good!  Please feel free to let me know if any help is needed :)

[...]

[1] https://lpc.events/event/19/contributions/2075/


Thanks,
SJ
