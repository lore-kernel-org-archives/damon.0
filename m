Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE24E1C76;
	Thu, 17 Sep 2026 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655836; cv=none; b=ZTmP5gzWFcSmxcqym3pOluuP84+Gm3BMNqGcTrpJqizaDDTg7PFoJU2Qc1bP38htN9HVMYHTObAc30lMq6rTJiCgKvA+nWfToGV1KTon12btC21QufloaRl6vJpOSL5F84LcE+L4UZ3H+n0Pu8hmLIuSK+9cQ2DS2x+JB2b8cYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655836; c=relaxed/simple;
	bh=SZIzUSR1nFqTWSIRDfocCNLg521X7fCgUMYiRt5NjvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpUe+GF4RV9kF9c5HTHE3prbJ88n/tFI6FwjuRllKObcalFbIA3HYMpFHENYR10iCzQVWXwQR+i2r0NPxSCSfRwX/lGnExr+frMrAqD77iChnjegUvmH9byhhXD4z4Au6Q1RlopjiISyL/5zPd+U8YvPT2ik6H5kDPHutD+kLEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJuPtYUr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJuPtYUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469181F000FF;
	Thu, 17 Sep 2026 14:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655835;
	bh=1YrFDyne4Mw/5P6NtQygUYrYZ/7F2ZHeKeQK62aWTkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KJuPtYUrTYQGek3CmOas+vaeay56yXNJlPharuTziS0HuGlv9+bFj/ng4L9Gqzw6X
	 hbpaKm3VOtxa0FgbVaXIOP9wrqWNNOD5jxtUSdiCMlJ23GDiLKRUqDAB2K7ezJoG7Q
	 vSrwhA5gdOE2jvEuvVmcoXyGNO3SMivVMty3JoUNg4CSOH2RxmA/og+GLIRfI/WeY9
	 L3R58YHYfK0xLMYcRKW43nU/p7Atc8VcsmEP0qpenjTPt5XTS4eySByP+xz7CsjRMv
	 Gpndqtq8HYdEZuExkh0B23Pv24u9Ne3OCLxV5/ApNZ89mpRUte/JZyyYP1sMQUC7x9
	 Ur9U5xfQ7qZhQ==
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
Subject: Re: [PATCH 00/10] mm/damon: improve readability, clarity and test coverage
Date: Thu, 17 Sep 2026 07:37:06 -0700
Message-ID: <20260917143707.91700-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917142210.90829-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 07:21:58 -0700 SJ Park <sj@kernel.org> wrote:

> Yet another batch of miscellaneous DAMON minor improvements.  Mostly
> focused on readability and clarity of code and document, and unit/self
> test coverage.  No user-visible behavioral change is intended.

Sashiko found no blocker for this series.  Sashiko send its findings to damon@
mailing list [1], and I reply those if anything needs to be clarified.  Please
refer to those for details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ
