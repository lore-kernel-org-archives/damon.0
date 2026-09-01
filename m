Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8853793A5;
	Tue,  1 Sep 2026 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788240396; cv=none; b=h9CZCY88qTEHvYYUgxxDr7MBrl0lY15qkD9F7nkQQ55z21R7JdmuuI7oE1cqQ5GAu/RU6zEfscieaSRSEPihUsGeyHgvjhdE1b2G6YN3ij/QOxEBkiojUShL8gQlitRxHXaegWGtcpYUfZDEEjM59tj+rKTnC3wtcbMdfEUezuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788240396; c=relaxed/simple;
	bh=V3m/tZGM7F8SH6VyH2dGeW7md8ZBrLPodTFdfZqvaWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7aNU+kCfDmC2c3SYBktG9L2F+iSgRQXFATIXWUPXeyTyyl53lVz8hUxQntON/T0KxXLA93gv2Rjs7PyDY5BVIasxV2u47Ws7QSZoEmqHbVnve1liDHs3xlbOVt6i3T9BpglLu7OJP/AqAPA6aiPP4kGzcg76RWjuOnYxj+Rm5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nyr59aCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyr59aCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C11B1F000E9;
	Tue,  1 Sep 2026 05:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788240394;
	bh=i0d6uoxX59JE6CAN12/4QKhpNFVtXkpS8bIPHrIcY1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nyr59aCUsrbXnN7xieacuiygyswVayN/35mPUGEaTYtflBfgXvg/AxzCVuwthR+RT
	 PldsjGvKuMechm69pCYLvgh6QB3NkIWNN0bMifNTEpPYjRwbrUg8Z7vTzj3al1CLqK
	 W2NItwsCAZCRC99LTtuAxx0lEnVExhA0dhQqlFa5X3GARo60iABAUiLkj2fGqLoU8/
	 VvWS05k7OvEUAPbfnhzcEWOXAydz8BGQPyjTYog/mN4LtjyqVnIHmDv2QTEhpJXE36
	 UiPMFLQfkGiexUsiRQ5+zX4XAR3FnN4w+tH6+/hgARbI1pwt/+8jf972udeYiaInKI
	 /Y3dOh0ARMmcg==
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
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 00/17] mm/damon: introduce data access-as-a-data attribute
Date: Mon, 31 Aug 2026 22:26:26 -0700
Message-ID: <20260901052627.6526-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901043417.2165-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 21:33:56 -0700 SJ Park <sj@kernel.org> wrote:

> TL;DR: extend DAMON's data attributes monitoring system to support page
> table accessed bit and PG_idle based access monitoring.

Sashiko found [1] a possible race that is introduced by this series.  I will
fix it in the next revision.

[1] https://lore.kernel.org/20260901052446.4122-1-sj@kernel.org


Thanks,
SJ

[...]
