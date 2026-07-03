Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA3221DAE;
	Fri,  3 Jul 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105472; cv=none; b=hqaOyYze78NIgvCjKrHjOukdfKYfW2pMBqIhI556n4kW/SrF5nGeoTMtAxVK9pJ9P93rvlLePib7xCUynszHC0c5rsAtthPyJbthn8z40ZNX2N6Nwa3rGH1+V2eJYCKUq2nTbcZXT/OaqofX+y1yp7QTHjvXX2coBam178vQAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105472; c=relaxed/simple;
	bh=8GpBwJkM5H2XtkfxwEtxg6k4Ww4SBCQ2VCDLdok94VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nsne/CJAwr8WhUK+YACTskAeoBKWJbfqX6agI+zynqB7FBb/v03yoFQeN2dmOY8a1t/yVHNSGU+yih8qGS8gXTXNkj9QRxUsx1StAODfiJEVwWbRYIXv0TVa4x5qvHhlg8eK91nX2Pb53mv/ZzM2Hfo2PXH7QH1qokNwqjuvJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBVsGjI5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBVsGjI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BFD1F000E9;
	Fri,  3 Jul 2026 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783105470;
	bh=OUtVmkb1xdoAAa5ycGAXmAUp7beR6p0/p7fLJoMo4dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CBVsGjI5LZTNS/uhJj9/3t+BgzAKJsCXhVGL852GhTKmqXDbSVUcLcsq4HBXqUxMH
	 Wy/ypjFnWkuIsT9MjRUblmc1KW04NX1gxqIJo1PkfxFV46d4KObLp44aLwmHGII9FX
	 sbhasIWXNAGX8qUTASCwf+N9Bg69ULbsnPy9e76ZObpUNPAdyCah9NVuH3qreKk0L8
	 uM0mYtIV/7rQaw004zI1EyG0+fdC3mYRL0UwaXswGsObCKvRkN0LyOpuRnLAuXv/T1
	 0RMhwEX/TEQKzDU0LmzmilFo1WPSVLpVYTDpfXVgdQflqrnQSDjJLnJP06+fkG4sfk
	 Se0pdGbSuOoew==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	Lian Wang <lianux.mm@gmail.com>,
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
Date: Fri,  3 Jul 2026 12:04:20 -0700
Message-ID: <20260703190421.100480-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702165235.86684-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Jul 2026 09:52:34 -0700 SJ Park <sj@kernel.org> wrote:

> On Thu, 2 Jul 2026 11:23:55 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:
> 
> > +cc all those you missed.
> 
> Thank you for doing this, Lorenzo.
> 
> > 
> > I really need to write a bot to do this, because I'm getting a little tired of
> > pointing this out :))
> 
> Good idea.  I will also consider implementing this kind of checks to to my lzy
> tool box [1] or hkml [2].

I implemented [1] the check logic on hkml.  Many things to fix and improve in
future, but seems working at least for this series.  You can use it like below:

    $ hkml patch check --check_recipients only ./0002-mm-khugepaged-add-damon-collapse-folio-range-for-external-callers.patch
    MISSING RECIPIENTS for [RESEND RFC PATCH v2 2/5] mm/khugepaged: add damon_collapse_folio_range() for external callers
    - Andrew Morton <akpm@linux-foundation.org>
    - David Hildenbrand <david@kernel.org>
    - Lorenzo Stoakes <ljs@kernel.org>
    - Zi Yan <ziy@nvidia.com>
    - Baolin Wang <baolin.wang@linux.alibaba.com>
    - "Liam R. Howlett" <liam@infradead.org>
    - Nico Pache <npache@redhat.com>
    - Ryan Roberts <ryan.roberts@arm.com>
    - Dev Jain <dev.jain@arm.com>
    - Barry Song <baohua@kernel.org>
    - Lance Yang <lance.yang@linux.dev>
    - Usama Arif <usama.arif@linux.dev>
    - linux-kernel@vger.kernel.org
    $ hkml patch check --check_recipients only ./0003-mm-damon-vaddr-implement-mthp-aware-damos-collapse-handler.patch
    MISSING RECIPIENTS for [RESEND RFC PATCH v2 3/5] mm/damon/vaddr: implement mTHP-aware DAMOS_COLLAPSE handler
    - Andrew Morton <akpm@linux-foundation.org>
    - linux-kernel@vger.kernel.org

It is also integrated with the interactive mails list [2], so that you can run
it without manually downloading the patch files.

FWIW, 'hkml patch format' automatically adds recipients based on
get_maintainer.pl, so this check is unnecessary for hkml users.  But this will
help me reviewing patches that not formatted with hkml or other similar
scripts.

hkml has a feature [3] to monitor new mails.  Extending it to run this new
check and send mails for check failures could be one of the ways to implement
the bot.  I'm not planning to do that by myself, though.  I will run the check
only for patches that look interesting to me, for now.

[1] https://github.com/sjp38/hackermail/commit/9ca6fa1f71edc7a219edeb41d4c7f91
[2] https://github.com/sjp38/hackermail/blob/master/USAGE.md#interactive-viewer
[3] https://github.com/sjp38/hackermail/blob/master/USAGE.md#monitoring-mails


Thanks,
SJ

[...]
