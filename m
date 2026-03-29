Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C845244684
	for <damon@lists.linux.dev>; Sun, 29 Mar 2026 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774796001; cv=none; b=sCJJiftHGaam7hzCFkw2ag+UfP3OUBOo+YPEi3LAWZ2uA1A4RBA9gGuyHqmyupr98vmVfk1cFc7d5BGN0jyvjx4oPWput198gPDl7YhCsAdALH0WSTkv3DWYrZ38AhznZGHRkHuT1aMEPxh6OANDhflRT+eRMz15u2fjJJb3G78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774796001; c=relaxed/simple;
	bh=XKaT9syjyaCnbMPh9xU8yW2PFKGdVEwY+cGqHnzDB+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKZIVLAv7Fluim4yu6o/qeAZPKjqMSCr++44BrUFl8WnOpZvGsQyBH1eM7Tg0dwNju0aOVRUcwTnQjzMGtrLw3lxYDJC6XGU8wP5g+TcSUjLMkvLt7FIZVTjErLNNWKwY3zXGkvX0axqllDnNgtEoLD86CmeoZT9zYKvbmmhhHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jui8O7Fg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jui8O7Fg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6BEC116C6;
	Sun, 29 Mar 2026 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774796001;
	bh=XKaT9syjyaCnbMPh9xU8yW2PFKGdVEwY+cGqHnzDB+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jui8O7FgvptlbXRZq73j9aMgokf476nbtGQfAayqrFGPM5M1rqd3PpYfp9BAMi6/C
	 fL1eqbXYDifbXJ8uOXBFoP/6CRY0JlTE7WsCOXYv8Ql9LuLfyErLa7+KlLM2FglaGU
	 qbE5Etji81WZiWyePGrLmECgunM4syabk01Xu1dgjjtuUczAsxEZBM5tqWAQc7x9Ag
	 IaKBp8zyGiEw04kTG2hbFf5L5x/F5oyVogAqGad+/+NX1nwsqKQDDM5nPSRUd2vcIj
	 4zjY/4Nq2TyBDizlHXcJYuS38zhF0RVFNBAb/WiGcUeD58vRzBqwh8uFdWKGlhl8Y5
	 e/uWoPCGQRWBg==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon: add synchronous commit for commit_inputs
Date: Sun, 29 Mar 2026 07:53:18 -0700
Message-ID: <20260329145319.47226-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329095602.3471-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 29 Mar 2026 17:56:02 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Forwarding Sashiko review for doing discussions via mails.

To my understanding, all the comments are same to those for v1, which we
concluded to be no real issues.  Please let me know if I'm missing something.


Thanks,
SJ

[...]
