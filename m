Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1A1348C5A;
	Fri, 10 Jul 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695554; cv=none; b=S/Kzb/Agp+s4xe4D0zjAlUg92XQnZpxc+S6gH6ujlawxqazsIrWC2qpj6t801LV+QtN+q6sMsg/V2I4oCbfZ3otu4zUSf1mvbzDFAvhGDjYshOhLUNPQlW5c5Y0VRLCFOO5qRb88fbFrIYu6+QNvooglarkpZjT/iFaUSKgHbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695554; c=relaxed/simple;
	bh=NXNQCLIrV+WdLw14BokOG34itnagsGEUs0NxFAH0G4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lk7ejLttb5mJpprKPU+wK9i6CtBaq1hYgK8c4JW8jEM2ZjbH6TSa+oTBt4pVEqkCbF+Eoy8l2YRS18QIGBFBU0M9aoPIigPMBhY0pDJLpfzg7CnYfsWcq17EGn78KLXbKBaQedklluyYvZOU48YjT8I+Y3+Yt8IQ6cbdB/o5REo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAET3Lve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAET3Lve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5381F000E9;
	Fri, 10 Jul 2026 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783695553;
	bh=kaHO7iM2fkBkcPXX7E/p4gh+FXOCsDoSAMVqpwRtKPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UAET3LveLjWX8B68X5OoBzwl8nLMnCMESO6AiBDf0f6br2bu+FSY99ro2+vJfAz64
	 DeRRmqxYubZ+aPo2o4mlrNDX9FsHGuEmWy2qhG53I9Rek1zIkK66Cq+mOMEOuYpHQp
	 dD8THo33ClgqdfHTq1T38PApc4m22RB+YxRdwdWwIALG5HPuP643Rw8eActmjWHK7v
	 kNNkfbzUpIfTOfTCHUeRWYnmxvsqN9tcLnlTLjMuZ2GFJ1TfdA3cDiBjpxdxjoclTR
	 qviEB7Y2/BMljyFgi75PuxISbyXnh9ZD2+cM/qv+VTd90REkj5HFX5D+bOys/r6NB1
	 sZ+wBLUtR32Lw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 00/19] mm/damon: introduce data attributes only monitoring
Date: Fri, 10 Jul 2026 07:59:04 -0700
Message-ID: <20260710145905.27704-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 06:46:29 -0700 SJ Park <sj@kernel.org> wrote:

> TL;DR: Introduce a way to get DAMON's best effort accuracy monitoring of
> user-demanding non-access data attributes.

Sashiko found no blocker for this series.  Sashiko sent findings to damon@
mailing list [1], and I replied to all the comments.  Please read those for
details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
