Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C043450410;
	Wed, 12 Aug 2026 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541862; cv=none; b=K1DjRzVSucr5/Z7O52HR4z+fl1WAaN6E8bIZTxKY7F6FSkUHiC5bBB+xzxuzYYuBRq9nR8Zj+LiYzFWMSkc8st6cq7A0F157MdbH9DWUg6Dm7rInyFJf+kiDdIsihgcA2BmhLPOA2MwPt03dH4tL6p7JO0VP3UtxMzd2Hh0bXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541862; c=relaxed/simple;
	bh=FTWKwiAqVWZbcD1niHla92oH0No24Son7x8TwrdUA1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXgHr7GOxuCe2rbfjHizq76qz8A6S0ts69sPNUUigj+KUHP+jx6oqS3ML3utl4KlfkwdCuMI6WyD2UbU9pDIMRUvzC/hMeBVm6StqMpHUIgS8tj0XWHwr6/GHEX5kmmRlE0CkN3RC4i1mXddPgwFRn2RxNPsPfvhIIxcVAhG9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1mlH5ct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1mlH5ct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C561F00A3A;
	Wed, 12 Aug 2026 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786541852;
	bh=nktaYrQMsX9kCJcq1vQI5eLxnBANn2ueYfqaIw7xb3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C1mlH5ctSn73LCSAInu+IRpXfrDqwbM/4k8vU847fCi6v1vkrFR5Qjm8jZaO9ITmq
	 cme7uuNedl71OCBETtRJ9QZKgikZ63PJOJTiYObTRhTN54rHrjSxXXgCPMTVLlCrzQ
	 HbdI9YPYNHhljYNvELunQBiHL252/BUkkQ4UaK8j+jaimjbuwXzhSiB/hoSzK+Ds4B
	 CFros/O6uQNIuf89zKJGFXbh0w9CrAP1ktPpxXZEDTbkTuwkP7yFTwe8MSqHjGON0V
	 MFL9rS9VTVXbpZ/t3d0r7whm+D9PbP8BFocLfuehi0cqDqnqC+0Irt29ZJuJCFwRQX
	 kTksztgFqC/aA==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] docs/mm/damon/design: add explanation of nr_snapshots
Date: Wed, 12 Aug 2026 06:37:22 -0700
Message-ID: <20260812133723.60261-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812104002.15225-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 12 Aug 2026 18:39:59 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Add an explanation of nr_snapshots to avoid misunderstandings.

Thank you for this series.

For the series:

Reviewed-by: SJ Park <sj@kernel.org>

I applied  this series to damon/next [1] tree.  We are now quite close to next
merge window.  We (mm community) want to focus on making mm.git more stabilized
and therefore ready for the next merge window, rather than adding more changes
that are not really urgent.  I understand this series is not really urgent.
Hence, Andrew might not add this patch until next -rc1 release.  In the case, I
will request adding this to mm.git after next -rc1 release.  So, no action from
your side is needed for now.  Let me know if you think this is really  urgent.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
