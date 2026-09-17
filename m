Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2F4A92E3;
	Thu, 17 Sep 2026 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682270; cv=none; b=d3a0nRG8zRBrvgGiho5g6XOrcgb7dLfqO7W+GpRhmJWxBdVvEtB9bYDBjDN8Od5mGS1sCR7vyTvsIgPDNTUwtcpcbH9jRz/fVZi3qLye6N1kPMz79Nt9zsEoPdTqx93EFlt21YIOsMQiNTmt+B+Jm0DulhHRQ14c4P2ywIboLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682270; c=relaxed/simple;
	bh=1UbTHhCjmKSqIfWbQRayVQA9agGfATUyD8RKjyYblu4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kVIZ0Fl56dz5UR07O8JzOzNglAR6c70LQSDmK0rtWc3dJ0WKzzDtkrlKEHs8PQ/z5LhvxIT5BG4nNgquPZhouWl9fjMhNHiskhKBSGsddWSEd6ll9sgetuuA5VILSJNKtQ2uM1adAf4/1wGrRU7XezXd3+CqA2zjuiZUg7yYqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SlSV3GrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SlSV3GrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A811F000FF;
	Thu, 17 Sep 2026 21:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789682268;
	bh=qGh/RcyyMvxZRhh0cS/raCPqx192hVwJtSPLUi51+yo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SlSV3GrUa7u740KQ4CZlB60JnMtupY8Ev4iwtRzGS52me7gHQv7TgCjcHrghNsYjK
	 EL3mwxqFkiXwPjYJs16VBTBuPxA3tfqe/kgirceityizCFXUp0PV27U84rh34GgJHA
	 jlqzkTV3WU9ulgb48/LCg3RjasB0BrcLCyX4m8pg=
Date: Thu, 17 Sep 2026 14:57:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <davidgow@davidgow.net>, David
 Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Lorenzo
 Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 damon@lists.linux.dev, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/10] mm/damon: improve readability, clarity and test
 coverage
Message-Id: <20260917145747.03fa94dcc327d43e84bef650@linux-foundation.org>
In-Reply-To: <20260917142210.90829-1-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 07:21:58 -0700 SJ Park <sj@kernel.org> wrote:

> Yet another batch of miscellaneous DAMON minor improvements.  Mostly
> focused on readability and clarity of code and document, and unit/self
> test coverage.  No user-visible behavioral change is intended.

Thanks, all queued up in mm-new.
