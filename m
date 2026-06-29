Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E59406825;
	Mon, 29 Jun 2026 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739405; cv=none; b=rSl6eePQu2jEUsxLVkMEvOTBAx1AUOMTvAa73bdYTJVcS5+GHB0++lmwC1GXk9y+Dq4/R2u07/2PKb3IWG12JoQipTg0nau+fFDOnZ+JgInYfgsgLfMjRZ0jaajQmFCnDl9rd/q56z6i79/8Jv9a6TN3qGiTpNSTNvOOMpdL4g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739405; c=relaxed/simple;
	bh=i8L2kBj/t1rCjlYlfdAaWdv4ktGPuTDUte4uXQwLrgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4PzuEafBIyxYMsTs4T5GChtgihC26KAogZJiNGaZp3FD4WxQC06vuhdJQuseRxVY3rpNM6MCeyN3+F8lAtC4rKJw9l3NQOj0ScYUY8WOT6OlTnWydD2nrzTYRKcn8fah97/+JksHvsuHS47XSftYjIDRYf1KsqB6hjICLDCAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0HZQCoy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0HZQCoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457541F000E9;
	Mon, 29 Jun 2026 13:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782739403;
	bh=mlAxXYXVGgouR1BHxhqF05/N6yt8unJyYd+g+wHldrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o0HZQCoycgaXPOttVMA87L/FwV0kiFBu9cH71xwSnUuV0mobalX62irez65uiFcKe
	 3k+zjWlQ6vgHLluq0Xl768naZIhvjIHmQU4RTJEtU/gtMpEU73d3PmEKZ4Ggocwoc4
	 18ELB7nnmHRqis5KbXLhAYeDxa+6CA9iZx/HpZI6vrjVqP8PHZiec/iWYUecgczzYN
	 SohbGcl3EvsI0ohHgx/0rCG4NnjCtqGAPkMTflCXorRjViYWx3PnoKOC0vRC+X6qDv
	 xXTX3+ntiRUL66dNz0BTBZwaRKYrYDqw7fiyZ303C5bmRr0rtU355T3Xzx+7IyYzac
	 rjpG9n1XOHzmw==
From: SJ Park <sj@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: s/SeongJae/SJ/
Date: Mon, 29 Jun 2026 06:23:14 -0700
Message-ID: <20260629132314.159577-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <akJB9EYPerO90rEh@lucifer>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 10:59:25 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> On Mon, Jun 29, 2026 at 11:45:03AM +0200, David Hildenbrand (Arm) wrote:
> > On 6/29/26 11:37, Lorenzo Stoakes wrote:
> > > On Mon, Jun 29, 2026 at 11:25:52AM +0200, Pratyush Yadav wrote:
> > >> On Mon, Jun 29 2026, David Hildenbrand (Arm) wrote:
> > >>
> > >>>
> > >>> [...]
> > >>>
> > >>>
> > >>> Just curious, why do you drop the author and copyright information? (can you
> > >>> even drop the Amazon copyright note?)
> > >>
> > >> Off topic, but I am curious how these copyright notices are supposed to
> > >> work in the first place. From what I have seen, the person who creates
> > >> the file normally adds one for themselves/their employer. But then other
> > >> contributors who make small/medium changes don't add theirs, even though
> > >> they should hold the copyright for the code they added. Bigger refactors>> sometimes add a notice but that isn't done consistently either.
> >
> > Yes, I saw it on bigger stuff as well, but not on small stuff, really.
> >
> > >>
> > >> So do these notices even hold any value? They certainly don't list all
> > >> the entities who hold the copyright to the code in the file. Only git
> > >> log can tell you that. Is there even any point in adding them?
> > >
> > > It strikes me as a rather loose convention.
> > >
> > > I am not a lawyer, but I would say that individual and corporate ownership of
> > > code are implied by S-o-b, not by comments in files.
> >
> > Guess it gets interesting once the SOB does not carry that information. Also,
> > some people might work at company X (and send code from company mail address)
> > but may hold all copyright by themselves.
> >
> > So even the git log cannot tell that story.
> >
> > But in any case, I would expect a comment about that in the patch description :)
> 
> Right yeah that'd be nice agreed :)

Thank you for all the comments.  I intentionally removed those notes, becuase a
better information could be found from the git history (I was using amazon
corporate email when I initially sent the patch) and seems the notes will only
be outdated and may confuse people.  I'm not familiar with the law, though.
But again, thanks to git, I think I could revert necessary parts if anyone
claims.

And I agree this intentions is better to be clearly explained.  I will send v2
with the explanation.


Thanks,
SJ

[...]
