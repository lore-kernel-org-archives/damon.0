Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3424036E48B;
	Wed,  2 Sep 2026 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329796; cv=none; b=hc8b84FpQ159mHDrrhEnDDzkgB3zOj9iPuCGbpL9NwB9tKw8N00xz22/Eju2tv4FOncwELuULlQkwwTDym1Fz/FKkR4W/8cvw5fFHT3X2fJzR2EfbMQuFzJmd1bw3byMAvWekwF5ayG2GasIYuRqFNdhp2EoIC3SUMXHs/BeBO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329796; c=relaxed/simple;
	bh=df9lM9HEu5E/py1w6LvCge4VSKqYYn85zxPTfe4YEkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8eyPxdc/dRR6+W6AEsJidpYeYcQqYPLOROjD1ppFAHWyEfLMXVR/gYZNWvoVICH2TcnPgI/Mq8euFVXsgSvX1W++UUIpRhFaB6TJ0mmWosjnqI/hrdtAwzRGlDXHfKNIQZrmBYh3S/au64LmLdsVqSoGCgHux2wuqLYuuKU6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1e89WsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1e89WsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618FA1F000E9;
	Wed,  2 Sep 2026 06:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788329795;
	bh=BjODJWm4HQ0zWK/uBNhYkH4uHbacHZCWiA6PuoaG+UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q1e89WsAYo18WECLuDiEp5fWTcq0n+WFFOj1SD4qSWJT//FyO73JSKFuM+tyXMV85
	 muzG6bod7qNplXg8aCpt/J5CztbBQe5DT9Ax1eDA58i2Q20sP5XqeAXpZnapWzSdSa
	 6gBR4bomJzq7h9XE8Vx/E+szEW+iKc3UGlTGsGJcCu7CT6nwfXJj1PxgsPpXqKbtS2
	 +3c2hlxMIUKKHn4hYVmtLFubOD+Nqb1xBxuy823jcUR1AlN5mKZK69NyQtlgPdf0vy
	 NSGiHOcstE2jXkL0sEIoqiwTI+7vrJEDWccdu6OOjfTEeXKiYuWE7kWzZoPCqHQdga
	 9LgVPRptuCVhA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
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
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 00/12] mm/damon: cleanup code, add test cases, and update guidances in docs
Date: Tue,  1 Sep 2026 23:16:26 -0700
Message-ID: <20260902061627.104566-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902054747.99370-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 22:47:33 -0700 SJ Park <sj@kernel.org> wrote:

> Misc cleanup, improvements and updates of code, test, and documents.

Sashiko found one better-to-do change for patch 2.  Since it is quite trivial
in my opinion, I asked Andrew to pick a fixup patch as a reply to the patch 2.
Andrew, please feel free to let me know if you prefer reposting.

Sashiko sent findings to damon@ mailing list [1], and I replied to all the
comments having some findings.  Please read those for details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
