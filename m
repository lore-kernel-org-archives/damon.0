Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A768307AF4;
	Fri,  3 Jul 2026 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096673; cv=none; b=BoPrpKCYuKYpklHLDg3weRHr8dImnebRiUtpg0CwPObc6f1s8vmuJyM8fyFcH2St0dJkj92ylfPCQIFBRAfyqdA4K2OBrwtgfLStk4L0kQEACJR+W7cKOZTnvGfjeaVEOizuMSl+7IgoZxfPJp3WEhLB3bHO9wmQNqz/hhrKnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096673; c=relaxed/simple;
	bh=qp9j0HmqhFt5UFOIlPPe3qy1EkFjvwdXwSTFuQnopTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcVz0MGsv45ZnI6qrwNFxuf+8X1mVahApoCeK/MocH7CgLwDNg6jQ9wKznqvTZcK1VbLY3SXq8IIrpldEIt9H6lXBwRM8LQRS/MAaS/+ACk0iipx6xy++Dsh3kEfbJMK5nlLfL0s1gakV2B8nnYNDhSjv43HKKdsYf/4Zu5sWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FALyA88g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FALyA88g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8721F000E9;
	Fri,  3 Jul 2026 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783096671;
	bh=sfgOhtUqXakhO/LJCSQi+Xtir7lK29w0aDyR77catJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FALyA88glPg893RXkoN9RTJO/MOwhlJg9JAvwHpslsw8oc/saSVG40yzlCTjD4DYW
	 pt2IRfk2i6zJBeIR0AOCP+1jWUbxQBrkTCz05/JpyoMmFMv6wjaD5nYDf6KPOBtSgm
	 nWs/kLSZwQ10zcUApI0QmTcyMVwg0KkwN/pga2/AvWdb+udqLdoYSPp7bHsBLnFTzI
	 +97XvOfKuIwa9aFsrLmJ5Sk9vJ0i8LKy0YU8jF08PMgvLXmsHxf7mYXVoDbSiWnaDJ
	 4NPQseUUiIW89u9P5QrZHDh85nHAlBZiao71tU+rK/Z1fiB2hxsBC9pFhkjUtniCWq
	 lmozENbGnPi4g==
From: SJ Park <sj@kernel.org>
To: wang lian <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2 0/5] mm/damon: add mTHP collapse and split actions
Date: Fri,  3 Jul 2026 09:37:35 -0700
Message-ID: <20260703163737.84760-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <F1C05416-5D04-4568-B8CD-D4376B0F3848@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 3 Jul 2026 09:10:51 +0800 wang lian <lianux.mm@gmail.com> wrote:

> Hi,Lorenzo
> 
> > On Jul 2, 2026, at 18:23, Lorenzo Stoakes <ljs@kernel.org> wrote:
> > 
> > +cc all those you missed.
> > 
> > I really need to write a bot to do this, because I'm getting a little tired of
> > pointing this out :))
> > 
> > On Thu, Jul 02, 2026 at 05:46:28PM +0800, Lian Wang wrote:
> >> include/linux/damon.h      |  10 +++
> >> include/linux/khugepaged.h |   9 +++
> >> mm/damon/core.c            |   2 +
> >> mm/damon/sysfs-schemes.c   |  77 ++++++++++++++++++++++
> >> mm/damon/vaddr.c           | 128 +++++++++++++++++++++++++++++++++++++
> >> mm/khugepaged.c            |  46 +++++++++++++
> >> 6 files changed, 272 insertions(+)
> > 
> > You are doing damon changes, and that belongs to SJ, sure.
> > 
> > But you're also changing core THP code? Please ensure you cc- THP people because
> > without our approval this cannot be merged:
> > 
> > $ scripts/get_maintainer.pl 20260702094633.75658-1-lianux.mm@gmail.com.mbx <mailto:20260702094633.75658-1-lianux.mm@gmail.com.mbx>
> > SJ Park <sj@kernel.org <mailto:sj@kernel.org>> (maintainer:DAMON)
> > Andrew Morton <akpm@linux-foundation.org <mailto:akpm@linux-foundation.org>> (maintainer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> > David Hildenbrand <david@kernel.org <mailto:david@kernel.org>> (maintainer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> > Lorenzo Stoakes <ljs@kernel.org <mailto:ljs@kernel.org>> (maintainer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> > Zi Yan <ziy@nvidia.com <mailto:ziy@nvidia.com>> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> > Baolin Wang <baolin.wang@linux.alibaba.com <mailto:baolin.wang@linux.alibaba.com>> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> > "Liam R. Howlett" <liam@infradead.org <mailto:liam@infradead.org>> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> > Nico Pache <npache@redhat.com <mailto:npache@redhat.com>> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> > Ryan Roberts <ryan.roberts@arm.com <mailto:ryan.roberts@arm.com>> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> > Dev Jain <dev.jain@arm.com <mailto:dev.jain@arm.com>> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> > Barry Song <baohua@kernel.org <mailto:baohua@kernel.org>> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> > Lance Yang <lance.yang@linux.dev <mailto:lance.yang@linux.dev>> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> > damon@lists.linux.dev <mailto:damon@lists.linux.dev> (open list:DAMON)
> > linux-mm@kvack.org <mailto:linux-mm@kvack.org> (open list:DAMON)
> > linux-kernel@vger.kernel.org <mailto:linux-kernel@vger.kernel.org> (open list)
> > 
> >> 
> >> --
> >> 2.50.1 (Apple Git-155)
> >> 
> > 
> 
> Thank you for pointing this out again, and I deeply appreciate all the tedious 
> work you do as a maintainer to keep the mailing lists aligned. 
> 
> As a newcomer trying to transition into complex feature development, I must 
> admit my initial design is far from perfect. I leveraged AI tools to assist 
> with certain implementation paths, and although I extensively self-reviewed, 
> tested, and reasoned through every single line of code, your and SJ's 
> feedback clearly shows there are still major architectural flaws. Just like my 
> very first kernel patch—which was strictly reviewed and guided by you and David H. 
> —I know that your sharp feedback is exactly what will help me grow as a kernel engineer.
> 
> I will completely step back and radically rethink the design of this series, 
> especially regarding the cross-subsystem encapsulation and locking hazards. 

No worries, take your time :)

> 
> As for that bot you mentioned getting tired of running manually—let me write 
> it for you. An imperfect newcomer who just made these exact mistakes knows 
> precisely where the traps are. I can craft a pre-flight patch check script or 
> a CI bot that automatically validates the `get_maintainer.pl` output against 
> the patch file diffstat before any email is dispatched, throwing a loud warning 
> if core MM files are touched but their respective maintainers are missing from 
> the CC line. 
> 
> What do you think? I would love to build this tool to save your and other 
> maintainers' valuable time in the future.

Sounds great!  hkml already has all building blocks for doing the check, so I'm
planning to develop such checks in hkml, but only for manual runs.  I ain't
develop and run a bot, since I don't have that much compute resource.  Maybe
you could save your time by reusing the hkml feature on your bot.


Thanks,
SJ

[...]
