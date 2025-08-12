Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9FE274B29;
	Tue, 12 Aug 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033146; cv=none; b=oOqk8Jbnq+bMSNeE8Dcqw9x7YNJTIM3WbZcoGnsIQuidQXypI0nAZDf8L7/7ZAfQ/6wwyEXrVL/b3+Of/HpyMxIJ112U3fMs+Yr1KPhD2tz9CKhux4rHFv0R8dy3Ut3uOidgLw2PGmhZ1gfml8GW/nRp4iUnH7n1vb3jqcrYOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033146; c=relaxed/simple;
	bh=C2zsIVIRo1pylk2kBdWKqydnPuw2DK2XE1QOzi+K2Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCOYUFRzwHEnPOKpGuVoJgNZiqWlDaQfmK02CXI70RCJkjQPlCs+Mfxc8EITNRXYEBYkWdCNbXBJV9IxF4OCurizs8Cxrs1w1rIKg/9MI2Sv6cYpmhF5Bnmlgj3CagSMhDkFL8Rfiw6K1lWGiY8fWEhZj8yor9bfWoVqHXbdRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ph4Apufw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph4Apufw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C08C4CEF0;
	Tue, 12 Aug 2025 21:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755033145;
	bh=C2zsIVIRo1pylk2kBdWKqydnPuw2DK2XE1QOzi+K2Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ph4ApufwntcndTJnGDVGmB0Wmr1yJ8HPZDZgc7e5LAc7dboHafZfcWc9KW593YWoO
	 9GByk+s0/ICmwjvz8q/WO3AsiHH04F6hnS6BMUsKtbnexpJ8Ei4WLCny+HC2Z+6A56
	 Qae4cwPeTluct8Jnx0iGNN8tzkhHAD/ieTWjLwo0wiY8adxv/M7F13Tqv759TuxYbW
	 oqz9rw3kKM5pmpepb/FIZmerJaiofXh7ofYXL5N2xCJ6C2cQ8U5Rb//5ofmsfLNRk6
	 Iu/kVmlnv9uj2yft9SsFzycpvZk9ROAsq8JeZc4EtkhIrS5lIqieSKEfdCuOtrsc8E
	 MP4rVMHRhqSMw==
From: SeongJae Park <sj@kernel.org>
To: Soham Metha <sohammetha01@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 6/9] docs: damon: fixed spelling mistakes in documentation
Date: Tue, 12 Aug 2025 14:12:23 -0700
Message-Id: <20250812211223.61339-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812204952.73136-4-sohammetha01@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ damon@lists.linux.dev

On Wed, 13 Aug 2025 02:19:49 +0530 Soham Metha <sohammetha01@gmail.com> wrote:

> found/fixed the following typos
> 
> - directores -> directories
> 
> in `Documentation/admin-guide/mm/damon/usage.rst`, and
> 
> - multipled -> multiplied
> 
> in `Documentation/mm/damon/design.rst`.
> 
> Signed-off-by: Soham Metha <sohammetha01@gmail.com>

Thank you for finding and fixing this!

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
