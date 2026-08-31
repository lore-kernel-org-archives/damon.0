Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5624B3E274C;
	Mon, 31 Aug 2026 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218350; cv=none; b=EwWBtFkCRIeiYxb1O+jToP9i6VlPW7dMHkBM5n7qMtubECXodZQATZqYDS7/hZAN/69FlLYqvDuEOI0rh2eVEwlLDl1h3KYPl8VLSxN2vU8w0MPGgW05sXuL3195izRnNzr7/sbH+D3lQb55Ad+yP8jtHWpKrRSc81uCbIpZL9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218350; c=relaxed/simple;
	bh=O27OuqTzbOyqdpww8xtjGmr8nASUQv50B+4T3b3XJxQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ox7NXDzMGlBBHGfmQPzuB61ufyIPz3JSbzR5BaXNdV1vvfZ9r3Zl7NWrhThBwqrBtBVm7q0THAWEJU4DYRP9n17TMG1IHOLIK15inGoReTXCAbdHRUNFK11C/j87CtzuLmdP0Qc8oS4oxNAL5Er2FZqTArY0IkGc3wgKzW5+JX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PJmA08jw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PJmA08jw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3829D1F000E9;
	Mon, 31 Aug 2026 23:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788218348;
	bh=u6CyxlFVtHRUTy01loukWarXdQfQjDuta3CuBNLTrpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PJmA08jwYORQGasmqBrDP7gPcZYCBCtlUqUw0KMBEYP7tI80J8g37S2MIHb+2wOCy
	 WjB+T8TNZa5RAZOJD6Dy6u7N+S/wbzNrIZpDVNOkJjCQihyOojyHBoACTRU1ltuDlf
	 NAP27N8iTMQXGCwJpkf+CK6b323WSX8HByJmtc58=
Date: Mon, 31 Aug 2026 16:19:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Cheng-Han Wu <hank20010209@gmail.com>
Subject: Re: [PATCH v2 1/2] mm/damon/core: remove unused
 damon_targets_empty()
Message-Id: <20260831161907.890b5e2d6c9a005205506674@linux-foundation.org>
In-Reply-To: <20260831145724.82387-2-sj@kernel.org>
References: <20260831145724.82387-1-sj@kernel.org>
	<20260831145724.82387-2-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 07:57:21 -0700 SJ Park <sj@kernel.org> wrote:

> damon_targets_empty() has had no in-tree users since commit
> 5ec4333b1967 ("mm/damon: remove DAMON debugfs interface") removed
> its last caller.
> 
> Remove the unused declaration and definition.
> 
> Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>

I assumed that a From:Cheng-Han was intended in this patch.

> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

