Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2A4B04BB;
	Fri,  7 Aug 2026 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786061383; cv=none; b=u937FTbH6gLDbZJsJH4ikZA4mS23rVAHrqS5BEn54SaJ743PFxlPAzpQGZkVfBeLuoyzlV+rKQZzyCsN9wqrlevKlMXGgITF2E6N5pz7GMRC8AJxZJdD4EoN8zqQFXb/YhvaAtqdX4IGDSmT6UF2pFfB9R5/hAEHFVqIG3wRmrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786061383; c=relaxed/simple;
	bh=VmLPvq4wC1IfP0SAylF++I5+i23jCGBcmntRCvsz83U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8TjIM/+W7coSXuR+exX9bq3uruK65fajNw4mO7MSV841PEGUQAR+znMn8odd+K5m/ict4fgAZmcybbMG7G/mRmLuOD1yAt/ZWgSECp5+0iIF1LjkrYpVY8o5az/QbzR1lu+BEoDajDSsRNJckAB+Tf49LKQXAXO68Edrbgf3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtbvyL6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtbvyL6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CA41F000E9;
	Fri,  7 Aug 2026 00:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786061381;
	bh=dZ5Mw0Ih/bGAuN0BQFkuLqJf8PbwxdcGV24qNLgz+NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BtbvyL6ZMna8HAKgywO+rmaE4EQ85ji20cRsyI/3rtd1ai4+PCGAzcDE93xIF5Q01
	 B5BPh1oT4iTNs4IeHq+V7rWpXGIUqY9UjANEHMscGd2ARRJs1f4bClCc2IVrjqyexY
	 XUXyEamjhpdN2aKu6SGIKd3aPS6x7dmhedDRHgcR6tOCY0ra90pVNPjCvTQqxHeMir
	 gEt5KBBtiAUiewgz9RD3+3mEMLIayqTrYkKPPkkL1BF38WsWPh6O16xDd7F4uYAqJN
	 AYVP6E380raZ6o6msbOO9O48SiLrGXWXY+fzM+hCHndtqKax52BIy8rtMAca2XtbwA
	 MfiLBnnWXt7UA==
From: SJ Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SJ Park <sj@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com
Subject: Re: [PATCH 1/4] mm/damon: defensively skip zone device folios in damon_get_folio()
Date: Thu,  6 Aug 2026 17:09:37 -0700
Message-ID: <20260807000938.79851-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <anS-vK1MaC8sWoMK@fedora>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 6 Aug 2026 12:05:00 -0500 Gregory Price <gourry@gourry.net> wrote:

> On Thu, Aug 06, 2026 at 02:37:59PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Jul 28, 2026 at 03:47:11PM -0400, Gregory Price wrote:
> > > All DAMON physical- and virtual-address operations obtain their folios
> > > through damon_get_folio(). That helper already excludes ZONE_DEVICE
> > > memory implicitly via pfn_to_online_page() and folio_test_lru(), but
> > > this is inconsistent with other callers in mm/ which test explicitly.
> > >
> > > Add an explicit folio_is_zone_device() rejection in damon_get_folio()
> > > so the guarantee lives in one place and covers every caller uniformly,
> > > consistent with other mm walkers that reject zone device folios.
> > >
> > > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> > 
> > Thanks, nice to make it explicit!
> > 
> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> 
> SJ Asked me to drop it,

I didn't asked you to drop this.  I asked your thought about revisioning this
for my concern.  And you replied [1] you can drop this.

I interprete it as a withdrawal, rather than being asked to be dropped.  My
dictionary is definitely not a good one, though.

Anyway, if your intention was not withdrawing, please feel free to push back
with the original change (explain me why my concern is wrong) or restart a
discussion for making DAMON code better in a way that can resolve both of our
concerns.

[1] https://lore.kernel.org/amoXZr2vB_q5q5Wu@gourry-fedora-PF4VCD3F


Thanks,
SJ

[...]
