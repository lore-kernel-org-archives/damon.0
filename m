Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24C3B1B3;
	Sat, 27 Jun 2026 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782590450; cv=none; b=eJAPWDr0WuqSZwX0QAZTtc2EYqjIh5k7oqPl062Pjp8+smwSAjFovIJDTz+fK9DUmyEHv0/Z63OkNtqSOMYTLFlnzYQEXOBrTmn5vPhez0blKcqBZlRPCW98BZU0fNEYZ/C/H/ocBlHEOPEAz/NbySe5sgrRgPloB78yAlZtL9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782590450; c=relaxed/simple;
	bh=f527CLu6mDRgsWD/bgLLx83lG1rZOEcbh2Lt45pTY+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtS9i/m2q+kUezSBP50Yg4Q1/M1IYMY5UNf4wWJTwKVYKqnnmTRARAH35xgYZdAFOt5zdb0K7qQ50I1kakylFTITrJAiefa8N2a4rnaV/JmhjUEbJSKTm5LL2IRH/T/2iTgUqECFpwDh3ZjEYmrEdHojeKFGfA4R6Z6mrKjJTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgTXvMRO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgTXvMRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80AF1F000E9;
	Sat, 27 Jun 2026 20:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782590449;
	bh=f527CLu6mDRgsWD/bgLLx83lG1rZOEcbh2Lt45pTY+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HgTXvMROlLUUssXMcUCvh/+cvDKX6k2vlwK6v8qdReaM3u1h1ioSE4Me+2fRXcyIk
	 inJLDQ1zjxXW8B3VIney1ILvGQ4cv7u3xhm67TBCRhDVBK7K+pSxdw+5L9SuobUoLd
	 2tPKBI7gaIxak504FRJjlnNKMv/xwsnCKUHE5naYXeKu9I3JsqxOZMqMm9gR+IGtzA
	 2QVqn9YlRc7OVbPFNQqiH/7FEr+zxfh6wPaSsQVhm9ExSY2FGd28zVDxvrpfilRxG5
	 Dy6eMrPEBFsKwYeFbZLI6Kwjn74gWbs8oGQUmidx+piLTLf/N6NyWXvH3F58yKHP7h
	 1KwZOfmzMu1CQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: s/SeongJae/SJ/
Date: Sat, 27 Jun 2026 13:00:45 -0700
Message-ID: <20260627200046.24616-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260627195630.24519-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jun 2026 12:56:29 -0700 SJ Park <sj@kernel.org> wrote:

> My legal name and preferred first names are SeongJae and SJ,

s/name /

Andrew, could you please apply the above when you pick this?


Thanks,
SJ

[...]
