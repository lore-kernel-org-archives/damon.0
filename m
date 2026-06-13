Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A1EE571;
	Sat, 13 Jun 2026 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309341; cv=none; b=omug8iQ77DLYjV2+Ts5E7kSug6r1zYcUySM3wtczJOK9SORwIaF+2tAyiL3n5HUShbHEq2tqgTE9fEGo6oETrvQ9vZkFmLE5I2J4O6uzmGCBsNp2ncJ+p7w1WeDj/pymZ41Y0RJ0Af8JpLecEGgeOsxr3Lb4Rjyo8PTrGtxEoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309341; c=relaxed/simple;
	bh=lUURjHSIiLgxi8zWPDFGVEmDdY3l4ohEKl1HNP31F5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKj8pJFrn5ng2Ws9aMkqB9UKJb/0owu9/ITgViH38vkFOT8a1JY9izcXsgWzhEtPWLIHnj59G5YM6KO0JfBGAgL8Kd6RIv0Q7BRD74AvU8due6AM1fPU7JhN/Qg4hucP3fm/Eu4Z+YvaOJh7lHYFbEQS7OZQOdTaYDB1oY2mit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT/RpASS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT/RpASS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ABC1F000E9;
	Sat, 13 Jun 2026 00:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781309340;
	bh=jwgdDxjpHcf51uQFCyHB9zZ8TZlVfxL9kvGTnnuc2og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WT/RpASSQHJBF/FCpzT7VvJcI/8vJCsTJVgtWdnX/u6SnGSXgt+9VBbPNygOHOuM3
	 Xi5O97z8PSzS9rDITHCy/37Y0tPkWdYCaBgFOyfL8G0LHF26aTZ9m1nvmmgMCb4aUo
	 4qxIbE4eYeEf9BA4rGrHfN1iz9LdP3D76YDWfmjYZsg9HyuXx1AMJtdwUnYfvyOgsn
	 85GMHHWMt7zp8woZNLRcNrCwyD7bu4TpaKoJWLRiWEDY8A9xBixHpRlwbClICFyzJ0
	 G2JLUEcyClWT3DaxJHlngGsOD25ag4WYye+S1Eu+2p/9OMU+NDO3xfOBUS97aMINZV
	 BJJS2sdZA/EqQ==
From: SeongJae Park <sj@kernel.org>
To: Shardul Deshpande <iamsharduld@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/mm/damon/design: fix a typo in the Address Unit section
Date: Fri, 12 Jun 2026 17:08:50 -0700
Message-ID: <20260613000850.935-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612154054.720363-1-iamsharduld@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Jun 2026 21:10:54 +0530 Shardul Deshpande <iamsharduld@gmail.com> wrote:

> The "Address Unit" section misspelled the C type that the DAMON core
> layer uses for monitoring target address ranges.  Correct it to read
> "unsigned long".

Thank you!  I found you sent another patch having this change following
Andrew's comment.  So I reviewed there.

[1] https://lore.kernel.org/20260613000715.791-1-sj@kernel.org


Thanks,
SJ

[...]
