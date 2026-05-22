Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58B22A4E9;
	Fri, 22 May 2026 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415214; cv=none; b=kOvOy4oe7ddju9vQ68WswrBvgtL0tFCvBwZwgophizTjmONYyz6VJqzOqhihrKSgAd/0RQ+ESA2G794uahg5EJCvmTamS954PltHIfGIfmtjydzhQLLvpN0G03pmXWpmevPs584q3b+UkS8rqe64SuEOVmD6hnRQmGDL88Ss3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415214; c=relaxed/simple;
	bh=sV0l8JDrwjoh1tY602B7FtwUVYZNNd5lD6n1hZmALEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2RZlCcPoMSq8B6SiR+bhipZl4+zETvI4yVN25dLZOBMic36QhIEHu+jVWKZH+qB+rUuB5+vDK2xJdiq76FoL0nw/PUvsj3zKhDKHkpGLkLBvLrCHSxghPo3aJSjr/mFXBPnl7kZ6nifgmWZUBU9pffhtycUhNWiXjCssnRSFMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD5g8W38; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD5g8W38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EA21F000E9;
	Fri, 22 May 2026 02:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779415212;
	bh=j9pmxg8KQowtANG3LtTGcpQGvZjt0wAeuNGrCjsdwH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WD5g8W38MwB9h3zXvTKvj5IXeyptjfDS2vSYH01gkkMj7ZGRuSSZiKDQtRJUaQYVA
	 vnvF8kisMW70s/NeZ4l1IFwXAb5kBFiceN1hTqEytvkAawmZo8RSTvkvrOsfFjAUno
	 nqAJXXcE1tNhe3BGs1Y0Fd1w9JrZX5Z5PsiGpB9GdHx3IL2nvfyXbq98BKVwFOhGov
	 q9vsFALqfgaeJcjsF4CGnH7A4ueMnC/7gRU449QMhBXLXBUeHBvLTfx5b6VcCb8tYW
	 QS+0BZX0voLni9ScFzHLtN0r2sV5ILPNn0bgaa4f4QBkWPZTR4tmAydHmbYo19PrPF
	 NbVll5H13DOrg==
From: SeongJae Park <sj@kernel.org>
To: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v2 2/2] Docs/admin-guide/mm/damon/usage: clarify current_value of quota goals
Date: Thu, 21 May 2026 19:00:03 -0700
Message-ID: <20260522020004.86551-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521202020.126500-3-maksym.shcherba@lnu.edu.ua>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 May 2026 23:20:20 +0300 Maksym Shcherba <maksym.shcherba@lnu.edu.ua> wrote:

> The sysfs interface for DAMON quota goals includes a `current_value` file.
> This file is not updated by the kernel and only serves to receive user
> input.
> 
> Clarify in the documentation that the kernel does not update
> `current_value`, and that reading it only has meaning when `target_metric`
> is set to `user_input`.
> 
> While at it, fix missing commas in the goal files list.

Nice!  Thank you for doing these!

> 
> Assisted-by: Antigravity:Gemini-3.1-Pro
> Signed-off-by: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
