Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031423515D9;
	Fri, 11 Sep 2026 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136942; cv=none; b=kipjwX4CF02h2N/MrqhvYtkAi1o22JVAFqqRMTs6NfZE15zeicQQHZkRzX85g0Y4yeL1J79BWXqDRTgA9Zbl6proLH8VCoKXKTwDx8+UyaVjPtuk8v0QoU3me3HAk8T02aQNS4sWtjmrlrWi8pAbyupUb0Wk4Cy0iO9QX761LyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136942; c=relaxed/simple;
	bh=laIdwsrNw+PQjJ2oqKPR+44PdWcQvsmOc/B7gNQRYro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhBcxPbaq2BRX2BsacGoKKoVkz6p0m7COBHP5Xa4Cw7z3M4A5lKvoZ3VC3U1WL9jkqIApaz9qSKtAB/akAJb1dPxWNwL8psiDruonbZCbhAnDQbmdtzrFR/4nXkmCw6O5QgCCBcrbJz4WnuvLJ+Q1/YZW84ayYh3VTR2lR44r6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD1M6nDs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD1M6nDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBE21F00893;
	Fri, 11 Sep 2026 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136940;
	bh=0+imRWCTv6smcDNW//4365ucDiUEC8sAvOg5IdNe59U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bD1M6nDshZEVXr+zFg8cAzmUh5bAdEXi7GQkHl2Re16P6383OWnqmoO8NEtKOgEIX
	 Dah2KCz4CUVivNTolTFCCZWU8NraTm8iVHKOxA5RSuMDdyY/iDCXVxvQ5PkwSrAtqi
	 yj79boC2n3vYk/5nt3oxrGq1K1cE2Z/JVdI8ORZGVv5UsPQyj/K22FJN9J3axvOT94
	 97nUl6QUb5M5c9UMQ13YUV1HRht1VXgndRk/6lpGzr94wZmidlgLWOSqiXLnae6ss0
	 gNH33cr5ey0+btv9y0d6DOXmi69b3i0cmpDjzz5F+Wa1yMifs/STNghRfHPzzchcXC
	 uk8VQsIPls4Zw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/7] mm/damon: introduce probe_hits_wsum DAMOS core filter
Date: Fri, 11 Sep 2026 07:28:52 -0700
Message-ID: <20260911142852.98297-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911135510.96914-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 06:55:02 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON can do flexible data attributes monitoring.  The classical data
> access monitoring can also be done using the attributes monitoring.  The
> access event is just one of the data attributes that DAMON supports.
> Users do monitoring to make some actions based on it.  DAMOS is a
> feature for automating that.  However, DAMOS cannot utilize the data
> attributes monitoring results.  It is still Data "Access"
> Monitoring-based Operation Schemes.  It requires users to set the target
> "access" pattern.
> 
> DAMOS core filter is effectively the same as the target access pattern.
> It is just a more generalized and flexible way of describing the
> operation action target region.  Introduce a new DAMOS core filter type,
> probe_hits_wsum.  It specifies the filter target based on a range of the
> probe hits weighted sum.  Using this, users can apply DAMOS actions to
> regions of specific data attributes pattern.

Sashiko found no blocker for this series but a minor documentation issue that
better to be clearified.  Because it is too trivial for reposting entire series
in my opinion, I asked Andrew to pick a fixup [1] for that together.

Sashiko send its findings to damon@ mailing list [2], and I reply those if
anything needs to be clarified.  Please refer to those for details.

[1] https://lore.kernel.org/20260911142522.98013-1-sj@kernel.org
[2] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
