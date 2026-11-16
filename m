Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842531;
	b=XPTGfSz3Y2gU8EHrFuU2gJqjT6HWlXhMIxpi2Y84gCBLPHtto6UUQudMneIvmfoBx/DZ
	 dVrvpMQbqPXobkFUDAE9v+Yj7ndsE4ZdIUbopHgWk4YcDLgmmqKdNEY9uvv8iqx0hGdPo
	 LMYHKUKG+Ak6gLVvJ8V0lAggL3hVOxZ6bPKf0tcijZX63tzZgJLza71PAoI9aaxchBfTd
	 YW3JG7j7icoZS+77dnn2q+oO9rSAP1YM6vHtGRvHRhr4yh06oAxjTyH7tbLAMAx1Z0J97
	 gYUh5dnpilfrjcXhFf9MjhFg4YclSyzfkdh/3EBp03rA2+/XpOuXw+DX4vHV2Z6wc4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842531;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vY0UbG0C3Stc7c0qISbj4M381KaRmNfpfTlZNvZJ4gg=;
	b=5Bq6hjGHfRF+YhsuETkswE/+DNdLvj9/yzK8dzx/WunMz0UVps/bbzNjCdKtucsdjNsH
	 h/iojEm+FaC44im+wtCCzdnmn9mVGE/+SeLh6KvMwsBzveaMkCzzjjrb4SJ9ejC03vaw/
	 REWK0+qA8jaQiYWdwP/jT2JW/p+ojwnJPkL/HmdrXo2nGQVe4NQwEnYb/KAJnt53N5hS8
	 8rhan2EBH2vPFscpPqg0dgCZH0WUXNDxOkC8iGojsItXV36EENce1oz2oGlBJmrNz6F4U
	 jotP1sHG7Z9ebhu/WsLTO/Obyv8Gj7bb8SAWmHG82/DXUxsd+03ZOOA3AtM/d7n56YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MW4jEOMd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80248606A31C;
	Mon, 16 Nov 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MW4jEOMd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168291F000C4;
	Mon, 16 Nov 2026 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842531;
	bh=vY0UbG0C3Stc7c0qISbj4M381KaRmNfpfTlZNvZJ4gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MW4jEOMdnWGPvEz5CGqm/KorZii8WlayfaxYQOGWixb9ToQDNIwgGyTyDOi+IurvI
	 ErG/UbUJCeqHZInLB5+s/pUew5wgPeKvlq0VS/EJNtJ3UNQKUN8hax/CmCib2GDERa
	 Jwi7WW0dWg7El81CKKt+cFHlJHRGDtBRMl9aIvWKZYksT+8W3NR6mo9o9DFZvKn3Yi
	 XqZPbfOVbnewWYxzJgobgZiF5p3encmi58k8O7CA9bV3IAnGykhjxxre7lAB31dh71
	 aEVQx2Tc0v4ZHI4Ey/AqaXeuNqjauz69ZoDp3bfjYCR9ooCfNpcWlUeY0kZNuZtMiM
	 0bx/CtQJtyhKQ==
From: SJ Park <sj@kernel.org>
To: Jason Angelov <jasonangelov@ucla.edu>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS interval changes
Date: Mon, 16 Nov 2026 07:22:03 -0800
Message-ID: <20261116152204.82241-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116-test-age-ms-filter-v2-3-3b265d59ec98@ucla.edu>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jason,

On Mon, 16 Nov 2026 03:06:23 -0800 Jason Angelov <jasonangelov@ucla.edu> wrote:

> DAMOS_FILTER_TYPE_AGE_MS defines an inclusive range for age in
> milliseconds to filter for target regions. Aggregation interval can be
> changed by users or intervals auto-tuning features.
> 
> Add a kunit test for each:
> 
> - convert region age to milliseconds, correct behavior at boundaries
>   for defined filter range
> - DAMOS_FILTER_TYPE_AGE_MS filter keeps correct behavior even when
>   aggregation interval changes

Looks good to me.

> 
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
