Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5C534441;
	Wed, 14 Oct 2026 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985971; cv=none; b=HaZkrkfVuDxXi7UzAZyHyKL5E3/jXc3BOoXtACc1LbkdQlgC2oe59Srox3WMFmbvDfa3ObATf+eyWLYZfp5J1YCpk4dbDab6YV7beuy4iDEBQJoBKhfhOQIr8yTN31If3NHXajubXfWA3Hjs9GCiF7DPKOT+fYgPVDDf12xPDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985971; c=relaxed/simple;
	bh=fVcfycRlOEElJyQh0w5ed2ebgn9Frj4EmHHrj7/wYFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GeaUEJkULg4QdofnC9cYpHSVlnPE2efCzB6Zw0nFsKqxxvBWpiVlYc69yotJTQEXqBMwAIY5bL7w2IlCz0Mnl1GxbrsZROPhndF6j24P6G5T6qBI8wWEBCz4xFSEzHGBE4L8e6px8XxZyGV/itxa4MRBiKN8lH91M6rfglnaldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYLOKPLa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYLOKPLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1C41F00A2F;
	Wed, 14 Oct 2026 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791985967;
	bh=fG9/eyKPy40SDyhi1NG0w7HlNhFj+AsuLqMKvUUaVp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WYLOKPLa/MdYb05p7MIzhm8DPN1Fgwnkw40e7Vcv0XpzcecOvuBfoJmJJQaMhJfg+
	 IluyIEbgm0hyTOWoLGLroYLWssx0UA+mqbOiopN0itMoaqt7pS7O/fG29bxG2exo+N
	 dgfeKQ7BhsBwwKtkwCcaUtdYNdcKED4O387x1vtSk2ctGUWbio1z6qtAjQqFvBnG+M
	 miDmC6C4EDRXpdP6D8ChQ+HjjbZNdo6NXJJFPHlvRqJ6Xcw5wxBSSMJjSH7kXJbq3L
	 ro2dwVTOErDsgzlI8Z3+W4BgotVk7LyxyyK4qGMdGES8mqrxODugGCb1QM1W3HW+B3
	 kyZN258MxGy3g==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/lru_sort: fix grammar and stlye
Date: Wed, 14 Oct 2026 06:52:38 -0700
Message-ID: <20261014135239.3596-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <dfa05908286b5e5684ea0002dde1ee99627154a4.camel@mailbox.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 14 Oct 2026 14:34:51 +0200 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Hi SJ,
> 
> On Tue, 2026-10-13 at 17:32 -0700, SJ Park wrote:
> > Hi Manuel,
> > 
> > On Tue, 13 Oct 2026 21:13:27 +0200 Manuel Ebner <manuelebnerli@mailbox.org> wrote:
> > 
> > > mention 'least-recently-used' AKA lru at the beginning
> > 
> > I think the readers would know what LRU means, and therefore
> > 'least-recently-used' is not needed.
> 
> I'm probably one of the few that doesn't know. I didn't think of the whole picture.
> You are right.

Thank you for accepting my humble suggestion.

[...]
> > > @@ -17,7 +18,7 @@ systems, LRU lists are normally not proactively sorted but partially and
> > >  As page-granularity access checking overhead could be significant on huge
> 
> Is this huge as in big or huge pages. For the latter I would put it: ``huge page``-systems
> or `huge page`-systems.

It is the former case.  "huge" as in big.

> 
> > >  systems, LRU lists are normally not proactively sorted but partially and
> > >  reactively sorted for special events including specific user requests, system
> > >  calls and memory pressure.  As a result, LRU lists are sometimes not so
> > >  perfectly prepared to be used as a trustworthy access pattern source for some
> > > -situations including reclamation target pages selection under sudden memory
> > > +situations including reclamation of target pages selection under sudden memory
> > >  pressure.
> > 
> > I cannot find what's wrong with the original sentence.  Could you expalin?
> > Also, I think the updated sentence is rather easier to misread.
> 
> It's two long sentences, thus (I think) hard to understand. I _rewrote_ it this way:
> 
> As page-granularity access checking overhead could be significant on huge systems,
> LRU lists are normally not fully nor proactively sorted but rather partially 
> and reactively sorted for special events.  These events include specific user requests,
> system calls and memory pressure.  As a result, LRU lists are sometimes not
> suitable to be used as a trustworthy access pattern source. These situations 
> including reclamation target page selection under sudden memory pressure.

I agree it is too long.  I like your suggestion, thank you.  Please ensure to
put two spaces between sentences, though.  The last sentence has only single
space after its former sentence.

[...]
> > > -DAMON_LRU_SORT finds hot pages (pages of memory regions that showing access
> > > +DAMON_LRU_SORT finds hot pages (pages of memory regions that show access
> > >  rates that higher than a user-specified threshold) and cold pages (pages of
> > 
> > rates that "are" higher?
> ... that show access rates that are higher ...
> and 
> 
> > 
> > > -memory regions that showing no access for a time that longer than a
> > > +memory regions that show no access for a time that longer than a
> 
> ... show no access for a duration that is longer than a 
> 
> Then ack.

Looks good to me.  Thank you for the nice suggestion.

[...]
> > > -Desired active to [in]active memory ratio in bp (1/10,000).
> > > +Desired active to (in)active memory ratio in bp (1/10,000).
> > 
> > I think use of brackets is also fine.  Let me know if I'm missing something.
> 
> There is 2x (de)prioritization, 6x [de]prioritizations, 2x[in]active and a few more in the
> file. They are all fine by themself, but not mixed. [] or ()?

That makes sense.  I agree consistency matters.  Let's use ().  Also please
don't forget explaining the rationale of the change on the commit message.


Thanks,
SJ

[...]
