Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC83B71DC;
	Mon, 29 Jun 2026 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727175; cv=none; b=CBX9PenMyGqS7TSP9mG/tWVYE+AOXL+NrdQNyb9WJSLPOcGW3yJCpEvsm9FdCi/zHlUQHOzTDpNR8JKxFg2f9HMZr6YJHzfy9ZJbYuc97/4zeul/WDMtYMIqdKaPqrKesUCJQ+ewxr4ZfoZgKuuAQZ/Ax5NYlBK5g+OluD5rSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727175; c=relaxed/simple;
	bh=xMapsRFdm1PFSt4n5Kx4fRcXn2nJ3ZS+Q6JyTjzdMu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIBCK8ElEdRDMicQVsGijBnLssHnNK/mUDuAjXCsM0t876SC0vj7wlyq3H3yPKn6fk2bOgZQlp6+PkVK7ckJV/nlxkHjuX3r1Skn05RBZh26Bd66JwyjsqKEqkxHupx2zOKhO43HkiPBZaxR/DA1jP5erGGohrB+LQZqSpIXEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRMhkfmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRMhkfmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D1F1F000E9;
	Mon, 29 Jun 2026 09:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782727174;
	bh=xMapsRFdm1PFSt4n5Kx4fRcXn2nJ3ZS+Q6JyTjzdMu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lRMhkfmugXROtoJKY71+zIary7pV5lG50fYBXPzQGviugLtdYhw3yg+eQyVnF3C5A
	 anfGNxHpT5nsMdb9JKuwkixzHvdWTdxdWfhG/+PwPzeXg26RVHaMz8D1xz7D2YE9D9
	 sqvsrHAqAAoondkDcXQTRVF80fo8nMFvUuzUPTDABK7YVH3+/oPQDEiW4DTusTR293
	 LPMbOdVRzKTN8dI05sVpilcE1kMRGhLuj7e94dFe8qSuukkIaX+JQiF9ycO5bTrjec
	 GfdJU1Lqtm2MXXSKjiXumpFFjs2mXyc628+h3kZLx8QWwoG6WkNcWfogvP/7dfpoT9
	 YwjOmJBYAiY+g==
Date: Mon, 29 Jun 2026 10:59:25 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, SJ Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: s/SeongJae/SJ/
Message-ID: <akJB9EYPerO90rEh@lucifer>
References: <20260627195630.24519-1-sj@kernel.org>
 <e29d1211-8bc3-433a-b1d7-d7fb44c2f0cd@kernel.org>
 <2vxzo6gtk89r.fsf@kernel.org>
 <akI8lkVb5CICUcWi@lucifer>
 <4b12ba64-5e2f-492b-80dd-b9be95604026@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b12ba64-5e2f-492b-80dd-b9be95604026@kernel.org>

On Mon, Jun 29, 2026 at 11:45:03AM +0200, David Hildenbrand (Arm) wrote:
> On 6/29/26 11:37, Lorenzo Stoakes wrote:
> > On Mon, Jun 29, 2026 at 11:25:52AM +0200, Pratyush Yadav wrote:
> >> On Mon, Jun 29 2026, David Hildenbrand (Arm) wrote:
> >>
> >>>
> >>> [...]
> >>>
> >>>
> >>> Just curious, why do you drop the author and copyright information? (can you
> >>> even drop the Amazon copyright note?)
> >>
> >> Off topic, but I am curious how these copyright notices are supposed to
> >> work in the first place. From what I have seen, the person who creates
> >> the file normally adds one for themselves/their employer. But then other
> >> contributors who make small/medium changes don't add theirs, even though
> >> they should hold the copyright for the code they added. Bigger refactors>> sometimes add a notice but that isn't done consistently either.
>
> Yes, I saw it on bigger stuff as well, but not on small stuff, really.
>
> >>
> >> So do these notices even hold any value? They certainly don't list all
> >> the entities who hold the copyright to the code in the file. Only git
> >> log can tell you that. Is there even any point in adding them?
> >
> > It strikes me as a rather loose convention.
> >
> > I am not a lawyer, but I would say that individual and corporate ownership of
> > code are implied by S-o-b, not by comments in files.
>
> Guess it gets interesting once the SOB does not carry that information. Also,
> some people might work at company X (and send code from company mail address)
> but may hold all copyright by themselves.
>
> So even the git log cannot tell that story.
>
> But in any case, I would expect a comment about that in the patch description :)

Right yeah that'd be nice agreed :)

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
