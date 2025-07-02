Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00331236A9F;
	Wed,  2 Jul 2025 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751500358; cv=none; b=W1AxphDR4tXY/wKg+nIcl+9kZP3B2R05+IPYJtr/HuxE7MDdGJAXN3mylTeucPOHkdRMgxi5pE5SJvju6rrhVPaNNFV/qAVKbvgrB1hImMszZQkSsdPeT4Fa2UOuXlwnw0D0ugMGHddiVz7i/YE9Vb6OAUTHVNQ8ZA7DEUoKhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751500358; c=relaxed/simple;
	bh=8+wiQu/n+o3eA50jpKYeQlFJkhmR1Nj/gNrTLBxw17g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oA5gMec/kqlf8TT+7ty/dT3MEg0hV1qYfMcy3ZmXMHG3y4sI6XlGTwNgcWsFz785Uasv3dY7DpJ0em1+ucHexhMxb0C2wTD6lcDmMbd2IF08fTdiOwi+ggQND4hRqjHT8AIhsk1wdWaJY+9zEXoHhT03BkGydHvoQA75SIQhbVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biCdBAfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biCdBAfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C38BC4CEE7;
	Wed,  2 Jul 2025 23:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751500355;
	bh=8+wiQu/n+o3eA50jpKYeQlFJkhmR1Nj/gNrTLBxw17g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biCdBAfKced/K7bPqQ72k0vzyRL3T213UpgoLqjMz94xcQ7nhz+v0zd99p1fnjHlL
	 4+fPONbi5/Ehtag3Oa47eqydjUs1/EZA18+Io+b47HIRbNPHDT+TIXe+Tg3tQ4m6/t
	 cOuLPLGfgY6PiWto4lDYpykHmDPIxQITFPjsbEWOxWo0amXhKeppOFBEJvRvJ5D8a9
	 f21LWH21bl2N8V4QbMXV9hMs02QsEM3fIYE22qzJCN+XMZ08kEK9jZ7neIjsxMQKF3
	 78NpoAjXfvoiTlLjfMiRVbz9Ah3/FR0eUiAxoZTXg9cpir/M26U/lHbRKDJ4xZwl1I
	 6ceW509nBh9uw==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: Re: [RFC PATCH v3 10/13] Docs/mm/damon/design: Document vaddr support for migrate_{hot,cold}
Date: Wed,  2 Jul 2025 16:52:33 -0700
Message-Id: <20250702235233.56805-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702201337.5780-11-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Jul 2025 15:13:33 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> Document that the migrate_{hot,cold} schemes can be used by the vaddr
> operations set.
> 
> Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
