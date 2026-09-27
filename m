Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BF6846A;
	Sun, 27 Sep 2026 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790499095; cv=none; b=WR7aWqX3vTgLG6MhUy9G3/VnxoaUJCa9HR+8f5jsIKYikPz+ZV1K0IxsK47X6ceUovU7S35xsE/QSpqFRsLXY1jy83H8bPu207QlAvmnuj6DgWMviNk0Q1RbMKJ22O8VH4W8vFVBDoRj+9QqiNUAY2YrumkbDB9NXp2nQaIqbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790499095; c=relaxed/simple;
	bh=Gaj7XqWXEUTvTZ2pwxNkw/M2q/QXDbU6QM4uoIcSnyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELEW26O7uu1Bvg/IwUx3Olo8YZ/HSf3KzzwkQRTrFyFZTAJ8m7MkXILBlCydZSc9zawsjKR+YHF/ewNGCC/XMmZaCSYP3ZwL3vbiWXLy1JgOT5pM8CdYld21hwKiXciFxKLt6YFWUjjyjpvULvtDj1U0/GzpKUkafkGgHa4ja64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zwix4i4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zwix4i4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0871F000FF;
	Sun, 27 Sep 2026 08:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790499094;
	bh=Gkq2TAehQkWrC1lsDaHNR2t/+poWofOsdUGZ4N/x/iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zwix4i4W1D6eEI5TVOeTmse+b839RviPXvE+wC26ru4pY26vGh9IvXoofxTrWvEFU
	 iiIqUZ97X3DmQ9Llk7g8IaRZeyEeqDXbJImpX3WqKP7Tgv7PJJdZI8HobbZCQMvCfw
	 wk6+XH6ZA2BeovyoSIg5at1Ov+kHGluIYtwcGgAHzUTRwZP6dZhbxpfvjl3ah/OQOe
	 Tp412R3nZ+0jcird7WnfvWgr1OqJcbJvLo3x9aN3Bc3LEA6CwSJBNP5gpHw2ZtuNm7
	 JvUJlERTFWLwK1IeaSfSrF5RPaWcH9DC6KFqNui+3ZB2B9o7k37hyQWakf+nxRdBes
	 NnTBf/Nh5noWg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Sun, 27 Sep 2026 01:51:27 -0700
Message-ID: <20260927085128.41506-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260926210737.8837-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 27 Sep 2026 05:07:09 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

[...]
> Okay, I will change the commit message in the next revision.
> 
>     Commit b3723b596b54 ("mm/damon/core: fix unconditionally skip last
>     region") fixed a minor bug.
> 
>     Add a KUnit test case to cover this behavior and prevent regressions
>     in the future.

Sounds good, looking forward to the next version of the patch!


Thanks,
SJ

[...]
