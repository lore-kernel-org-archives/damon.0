Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF7827D77A;
	Mon, 15 Sep 2025 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959566; cv=none; b=QzttyZUh6dtF4C7kvLGRyZK80JfRjauDKhkGlFtS/2wskqOZ2F9rC/nlhcwvXG1Mh/gVVlNcsgs770qtHyqrOB84c/6CxuaxT4bISP5aZZi2N/eYLdak7GrBEXNCQVeNwjmaahc0bA8xHRe6pvJ7pLCd595YZ1dyFmK19CjFg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959566; c=relaxed/simple;
	bh=R3K4Y/dSLmEWyD8ymG6km0XDDMmddNGUWTI1tUqPvlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhG0vxKm2clrrxmJ2no5AOxzVKXRDaSMI4rR2T1Lm5H+7RNrRyqdNdwlQUThIO37miD7yTLTcGCYDXsVJYwlyeUJLHYVzq5wfKTUS9iR2HLraXJS8KTOiNyC5D6K+nLH4YZ1W+bkAm2d5yXg5U3U6VRh7kX9Ni74jLYxJiQ32dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNOOGc5+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNOOGc5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF298C4CEF1;
	Mon, 15 Sep 2025 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757959565;
	bh=R3K4Y/dSLmEWyD8ymG6km0XDDMmddNGUWTI1tUqPvlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNOOGc5+WpUFS+sVqB6MYWVbIYSAtkpW//y6DplI9q2tBqaUiAlCeCpZ8l1VKNjZI
	 6yEat5zqx6RVXZz9RSb3YEHO0moWzs0cZMpVPf8GBCeLVG3tNjHHaQhvsZU52cttfT
	 cgCZP67AKz1wOTtsy3hxhaULVL7KuE3IdwYofIqDTHjfSyE0z0jmsOBwtyzYflZoNe
	 gDNp4Xpktrb9EWPORQf+6ecHnDF2PQMDEz8NGAozxLp8QLSnzmCX6ZHlkx9udhiLh0
	 FAs6FOOIieu59NalkqA05QfmQkoONC3RepxqOOCjKqBc6yXzRdCm6jkO6Ud9oUbwQ2
	 o5DgjskJMFldQ==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/6] mm/damon: misc fixups and improvements for 6.18
Date: Mon, 15 Sep 2025 11:06:02 -0700
Message-Id: <20250915180602.109892-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915152823.1605591-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 08:28:18 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Mon, 15 Sep 2025 08:25:40 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:
> 
> > On Mon, Sep 15, 2025 at 8:08 AM Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > >
> > > On Sun, 14 Sep 2025 18:58:01 -0700 SeongJae Park <sj@kernel.org> wrote:
[...]
> > > > Finally, the sixth patch updates MAINTAINERS section name for DAMON to
> > > > just DAMON.
> > >
> > > Hi SJ,
> > >
> > > I was unable to find this sixth patch on the mailing list. Maybe it got dropped
> > > somewhere? : -)
> > 
> > I'm seeing it show up for me, this is the link I'm looking at
> > https://lore.kernel.org/all/20250915015807.101505-7-sj@kernel.org/
> 
> Hi Joanne,
> 
> Thanks, it seems like linux-mm wasn't CCed on the 6th patch.

Thanks for sharing these findings, Joshua and Joanne!  I was using
'get_maintainer.pl' via 'hkml patch format' to fill in the recipients field,
and it warned me with recipients review step, but I missed this.  I will ensure
linux-mm@ is Cc-ed from the next version.

> I should have
> checked in /all!

FYI, if you use hkml, you can list all mails of a thread of a mail using 't'
key on list screen, or 'm' key on the list screen -> '2: list complete thread'
item on the menu screen, instead of '/all'.  It should work for cases like
this.

> Have a great day!

You too!


Thanks,
SJ

[...]
