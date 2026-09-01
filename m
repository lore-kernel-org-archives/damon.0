Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A372F7F19;
	Tue,  1 Sep 2026 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306792; cv=none; b=AiRtxM8kzHVmSCTbCYeq+uEtb0J26GKQyAMfbmkS860afSSmotLanTZS5+BcmrJrxr1NfxMX1yaaFZcSWj5B3pcU/Hn4Cq7Tqs2zUARLnHt5o+iRxPiL/vAVih+hbJkxX8dgB7Gs0WU2ZkiydFcTe3SO43yx1PkbsNDijp0CEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306792; c=relaxed/simple;
	bh=sUjMRIwGazk97tgRzt2NcdkYZy11frn/cf7ZivttDRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJvvxZxrS5hdi/8GhIwC1v+kSX4N1Z9OW0KVgd2gt1LhujjvjGeh2+AKAnR1ec/GkQh6f7Ynnl1KnyxZaz6y5OAWaVsHhqTkRePeyaXBaUEps0Aq+Dl+W9ftMUNXtUOCAZx5wLXCGMz8L/QUJxHhNWGGL3iLam5jncD451qM8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5l1te8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5l1te8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2CA1F000E9;
	Tue,  1 Sep 2026 23:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788306790;
	bh=qwo/oxJowOK5NCuSw9/wxwXOLTwjKgO41GHpF7gUkAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5l1te8nyBGdwEKr1MLPS4uV0mJRTy6THlxjrphsJBK8B6R6L0vFvepMGAFim/ea3
	 HZqx1yzImxla/z2lPgHCf+N68TyJHoSygquTqNiblWau0Cg1kItC+3WV97Zbtc7WYe
	 MA6cZIQerAzA2dLFjvkC6FyVLkvtxYR5RDZp0cy9jARPAMJ5liyog7zQRyB0xY4lZj
	 QTrOB8hYU54uiNDarQfwBAoHf1jRVuZn1HRYwrhmi96pPtPP5hYQWYOgkCCFpj1YhH
	 vMQjCkrZpREBgWrEvBeRFUioa5v4FluEeFS8SpyMB+VUxWoZvAKjh5Huj9IgGaSR1J
	 qKGQKv7mEs6vg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
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
Subject: Re: [PATCH v1.1 00/17] mm/damon: introduce data access-as-a-data attribute
Date: Tue,  1 Sep 2026 16:52:57 -0700
Message-ID: <20260901235258.103447-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901101800.0d76452eb310a4b958d792fd@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 1 Sep 2026 10:18:00 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue,  1 Sep 2026 06:24:47 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > TL;DR: extend DAMON's data attributes monitoring system to support page
> > table accessed bit and PG_idle based access monitoring.
> > 
> 
> Thanks, added.

Thank you Andrew!

> 
> What does "v1.1" mean?

Sashiko found a low priority issue on the previous version.  Before the Sashiko
era, it would be fixed by posting a fixup as a reply to the thread and asking
Andrew to handle it.   But that cannot get review from Sashiko.  So I did
reposting of the series, but with minor version update.  I use this kind of
version scheme nowadays.  If it makes someone be confused, please let me know.
I will be happy to adapt.


Thanks,
SJ
