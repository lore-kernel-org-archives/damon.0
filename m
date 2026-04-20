Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115238947F
	for <damon@lists.linux.dev>; Mon, 20 Apr 2026 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675217; cv=none; b=tFkcJkjF0pDAu3TYVzKW3jkmKu0cJDrJGGTbcK9ePSnubJ66AywBhK1NJqZIfJAWVI0CU5xV+R7xX6CvDEpyuFF8xOLs405/HgZcn//8+HZFpA5BKaF15RS2JKwDniKONBDlhNmcMivSTqqOPzeihrxdjB21Bpg6rlN1VbjESXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675217; c=relaxed/simple;
	bh=SmmZJtzy83jxfpGrvSpT8LlluquI6EwIT4m4JdL0Fls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OYI26YlUfwBLltUsmHT5ingOJRDoiv2T4+g28HkkzWAbLYI4/hIdCFR3CNBlOGdjCflSeGe3qwFi01rf6QrG0sYLX2GAiBOkEnPG0MOJE+ml6CbtPne4y/ixwvpq1cJYa02QwnmmB5zmivpm2Bq3KxgzGPc6t7xqBx/6aI7ZjxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOcQmLhq; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOcQmLhq"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so1755196a91.2
        for <damon@lists.linux.dev>; Mon, 20 Apr 2026 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776675215; x=1777280015; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PjUw1MUTmp5dgmDDe13bezBVb5C7PS10Nn9b4igxUf0=;
        b=ZOcQmLhqgjPKLMmGm0031HaBg/z6xPfzKS884sVU5c1aHOpvuCPEW2x26GkSELOP/9
         +xrGsYjkgnQxKNizIP2A6RALpXcP14/u32u8tili4cEOJXnT2CHiElm24I90RJn2OYI7
         l6AlBn8P8AWpCyLrGSjtU7FwAkIpCOCxq3bif+8w6DWgHvt8OLOXqzygj8vhv5YB8Mtx
         Lqjtj5Y+5UB+oXjsHCfnjlxqPOv8GczMt4WvFOs69ebD7zhfXvxT6hsNlakXMALCyPf1
         d5NYfnVj9aYy39GBGj8mPj0OChvT7RIWTDDlEi/XF+/R4J3bFvdR3zwHxgPZDZ2nnOLs
         O7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776675215; x=1777280015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjUw1MUTmp5dgmDDe13bezBVb5C7PS10Nn9b4igxUf0=;
        b=FeEyQ0Hgw1089DLdXFwK5Q81LbxfS+yjdWciMSwKvPse8R5bwKFi4LLlk6XgGnkb/D
         FY+NWK4kjR7JmnQ6u1lr5lo7oc8PS2N90lA5CBuhRxUHJ4iK2NrKv2SP1JOFY7oni5I6
         +sTOgShwbV0KAQEocMuX5mOKljOz5b0PWdFwHcqnMEwww08wYTMqPU9IOM5OZOwC71q7
         I9rYMu3IWxIAWSmETn0RrsTWY2Rva18nohMS8pZCCT1zwAcWo5GlSqWjUqspDd9A0Oyz
         bSLgzwMUdB2I37m1geFMozCXGFac6bo/RpnHMwX0exx7Jx4fvWrHcnKqnIHPr02BqPNP
         LtyA==
X-Forwarded-Encrypted: i=1; AFNElJ8nhRhLYlOm6QMV7kvlJSBe4isldgM8QDjbcizpf5lNvDdWp+4sMc+vvLh5bWei9KTrpE0ikw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDACsKNAeVzYsDaaOZZhntLA2f/fBmnN1IbPvYsPYvom7Op0g3
	8U4LvFvlv4Lo1DWhotAhz4yjicF4W7yd5ms4NZgMPUERxQh/pt5Ey6Xa
X-Gm-Gg: AeBDievROdjkJtjQrU3pd2rPX/qxdfVnKUqImzISEZ5E38N11kNN+ICuVmO7FsqLMyZ
	zkVKngjvhUwC7LKvOj9DwCkOSfNGOj6kXTV0dVqBynJK4EXXPMC6da4UxILKQPVUe/ySKli0brF
	bEgArMPBqNAHAvfmmsA22DDQmp+uGPJiVen3dFVQmV+sp/leXmSZOyVileuOcTx43DFXCoIxfNF
	QcxwimbJ9LULOMkChz7lkGPcl9a7QVxlQaCMnth53LBzX+Ynj10/Ryh2HO5Drqo2WHp6weFaYXs
	CxQQmVQCPTnNaB1tG+sHGMe4lDFvpk/xFhI2+BSRfxmv/AH6qBcmxOLi8oBfx7nnddVn23qRFLp
	bQgRFdDAH5LavW2q5jyo0QHOzPf7Vr94a5/tC0ko+aGsNnVreTKLHCHWY0CjMQ5VtVS6lFI1XU5
	vTxKu2r2mHhA419k0lYKW+/SEoUGPFb9CfE7v2d44wVnXlWlsb5k90N/ePy5A6
X-Received: by 2002:a17:90b:2f83:b0:35f:b313:84ca with SMTP id 98e67ed59e1d1-361404aef96mr13393211a91.27.1776675215093;
        Mon, 20 Apr 2026 01:53:35 -0700 (PDT)
Received: from localhost.localdomain ([14.218.34.206])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141990bb6sm10104820a91.17.2026.04.20.01.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:53:34 -0700 (PDT)
From: Junxi Qian <qjx1298677004@gmail.com>
To: linux-mm@kvack.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/sysfs-schemes: fix use-after-free on memcg_path and goal path
Date: Mon, 20 Apr 2026 16:53:32 +0800
Message-Id: <20260420085332.178473-1-qjx1298677004@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memcg_path_store() and path_store() free and replace their respective
string pointers without holding damon_sysfs_lock. This creates a race
with the kdamond thread, which reads these pointers in
damon_sysfs_add_scheme_filters() and damos_sysfs_add_quota_score()
via damon_call() during a "commit" operation.

The race window is as follows:
  Thread A (commit):  holds damon_sysfs_lock, triggers damon_call()
  kdamond thread:     reads sysfs_filter->memcg_path in
                      damon_sysfs_memcg_path_to_id()
  Thread B (sysfs):   calls memcg_path_store() WITHOUT lock,
                      kfree(filter->memcg_path), replaces pointer

Since Thread B does not hold damon_sysfs_lock, the kdamond thread can
observe a freed pointer, resulting in a use-after-free when
damon_sysfs_memcg_path_eq() dereferences it for string comparison.

KASAN reports the following on v7.0.0-rc5 with CONFIG_KASAN=y:

  ==================================================================
  BUG: KASAN: double-free in memcg_path_store+0x6e/0xc0

  Free of addr ffff888100a086c0 by task exp/149

  CPU: 1 UID: 0 PID: 149 Comm: exp Not tainted 7.0.0-rc5-gd38efd7c139a #18 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x55/0x70
   print_report+0xcb/0x5d0
   kasan_report_invalid_free+0x94/0xc0
   check_slab_allocation+0xde/0x110
   kfree+0x114/0x3b0
   memcg_path_store+0x6e/0xc0
   kernfs_fop_write_iter+0x2fc/0x490
   vfs_write+0x8e1/0xcc0
   ksys_write+0xee/0x1c0
   do_syscall_64+0xfc/0x580
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  Allocated by task 147 on cpu 0 at 12.364295s:
   kasan_save_stack+0x24/0x50
   kasan_save_track+0x17/0x60
   __kasan_kmalloc+0x7f/0x90
   __kmalloc_noprof+0x191/0x490
   memcg_path_store+0x32/0xc0
   kernfs_fop_write_iter+0x2fc/0x490
   vfs_write+0x8e1/0xcc0
   ksys_write+0xee/0x1c0

  Freed by task 150 on cpu 0 at 13.373810s:
   kasan_save_stack+0x24/0x50
   kasan_save_track+0x17/0x60
   kasan_save_free_info+0x3b/0x60
   __kasan_slab_free+0x43/0x70
   kfree+0x137/0x3b0
   memcg_path_store+0x6e/0xc0
   kernfs_fop_write_iter+0x2fc/0x490
   vfs_write+0x8e1/0xcc0
   ksys_write+0xee/0x1c0

  The buggy address belongs to the object at ffff888100a086c0
   which belongs to the cache kmalloc-8 of size 8
  ==================================================================

Fix this by holding damon_sysfs_lock while swapping the path pointer
in both memcg_path_store() and path_store(). The actual kfree() is
moved outside the lock since the old pointer is no longer reachable
once replaced.

Fixes: 490a43d07f16 ("mm/damon/sysfs-schemes: free old damon_sysfs_scheme_filter->memcg_path on write")
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
---
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
#include <errno.h>
#include <sys/stat.h>

#define DAMON_BASE "/sys/kernel/mm/damon/admin"

static volatile int stop;
static char memcg_path_file[1024], state_file[1024];
static char real_memcg_path[512] = "/";
static int num_extra_cgroups = 200;
static char cgroup_base[256];

static int write_str(const char *path, const char *val) {
    int fd = open(path, O_WRONLY);
    if (fd < 0) return -errno;
    ssize_t r = write(fd, val, strlen(val));
    int e = errno; close(fd);
    return r > 0 ? 0 : -e;
}

static int create_extra_cgroups(void) {
    struct stat st; char path[512]; int created = 0;
    if (stat("/sys/fs/cgroup/cgroup.controllers", &st) == 0)
        strncpy(cgroup_base, "/sys/fs/cgroup", sizeof(cgroup_base));
    else if (stat("/sys/fs/cgroup/memory", &st) == 0)
        strncpy(cgroup_base, "/sys/fs/cgroup/memory", sizeof(cgroup_base));
    else return 0;
    for (int i = 0; i < num_extra_cgroups; i++) {
        snprintf(path, sizeof(path), "%s/damon_poc_%d", cgroup_base, i);
        if (mkdir(path, 0755) == 0) created++;
    }
    if (created > 0)
        snprintf(real_memcg_path, sizeof(real_memcg_path),
                 "%s/damon_poc_0", cgroup_base);
    return created;
}

static void cleanup_extra_cgroups(void) {
    char path[512];
    if (!cgroup_base[0]) return;
    for (int i = 0; i < num_extra_cgroups; i++) {
        snprintf(path, sizeof(path), "%s/damon_poc_%d", cgroup_base, i);
        rmdir(path);
    }
}

static void *path_writer(void *arg) {
    long tid = (long)arg; int i = 0; char buf[512];
    while (!stop) {
        switch (i % 4) {
        case 0: snprintf(buf,sizeof(buf),"%s",real_memcg_path); break;
        case 1: snprintf(buf,sizeof(buf),
                    "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX_%d_%ld",i,tid); break;
        case 2: snprintf(buf,sizeof(buf),"YYYYYYYYYYYYYY_%d",i); break;
        case 3: snprintf(buf,sizeof(buf),"Z_%d",i); break;
        }
        write_str(memcg_path_file, buf); i++;
    }
    return NULL;
}

static void *committer(void *arg) {
    while (!stop) {
        if (write_str(state_file, "commit") == 0) usleep(10);
    }
    return NULL;
}

static int setup_damon(void) {
    char path[1024]; int err;
    snprintf(path,sizeof(path),"%s/kdamonds/nr_kdamonds",DAMON_BASE);
    write_str(path,"1");
    snprintf(path,sizeof(path),
             "%s/kdamonds/0/contexts/nr_contexts",DAMON_BASE);
    write_str(path,"1");
    snprintf(path,sizeof(path),
             "%s/kdamonds/0/contexts/0/operations",DAMON_BASE);
    if (write_str(path,"paddr")) {
        write_str(path,"vaddr");
        snprintf(path,sizeof(path),
            "%s/kdamonds/0/contexts/0/targets/nr_targets",DAMON_BASE);
        write_str(path,"1");
        char pid[32]; snprintf(pid,sizeof(pid),"%d",getpid());
        snprintf(path,sizeof(path),
            "%s/kdamonds/0/contexts/0/targets/0/pid_target",DAMON_BASE);
        write_str(path,pid);
    }
    snprintf(path,sizeof(path),
        "%s/kdamonds/0/contexts/0/schemes/nr_schemes",DAMON_BASE);
    write_str(path,"1");
    snprintf(path,sizeof(path),
        "%s/kdamonds/0/contexts/0/schemes/0/action",DAMON_BASE);
    write_str(path,"stat");
    snprintf(state_file,sizeof(state_file),
             "%s/kdamonds/0/state",DAMON_BASE);
    if ((err = write_str(state_file,"on"))) return err;
    snprintf(path,sizeof(path),
        "%s/kdamonds/0/contexts/0/schemes/0/filters/nr_filters",DAMON_BASE);
    write_str(path,"1");
    snprintf(path,sizeof(path),
        "%s/kdamonds/0/contexts/0/schemes/0/filters/0/type",DAMON_BASE);
    write_str(path,"memcg");
    snprintf(memcg_path_file,sizeof(memcg_path_file),
        "%s/kdamonds/0/contexts/0/schemes/0/filters/0/memcg_path",
        DAMON_BASE);
    write_str(memcg_path_file, real_memcg_path);
    return 0;
}

int main(int argc, char *argv[]) {
    int duration = 60, n_writers = 4;
    if (argc > 1) duration = atoi(argv[1]);
    if (argc > 2) num_extra_cgroups = atoi(argv[2]);
    if (getuid()) { fprintf(stderr,"Need root\n"); return 1; }
    create_extra_cgroups();
    if (setup_damon()) { cleanup_extra_cgroups(); return 1; }
    sleep(1);
    pthread_t w[8], c;
    for (int i = 0; i < n_writers; i++)
        pthread_create(&w[i],NULL,path_writer,(void*)(long)i);
    pthread_create(&c,NULL,committer,NULL);
    sleep(duration);
    stop = 1;
    for (int i = 0; i < n_writers; i++) pthread_join(w[i],NULL);
    pthread_join(c,NULL);
    write_str(state_file,"off");
    cleanup_extra_cgroups();
    printf("Check: dmesg | grep -A20 'BUG: KASAN'\n");
}

---

 mm/damon/sysfs-schemes.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5186966da..005cfecb1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -543,15 +543,20 @@ static ssize_t memcg_path_store(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
-	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
-				   GFP_KERNEL);
+	char *path, *old;
 
+	path = kmalloc_array(size_add(count, 1), sizeof(*path), GFP_KERNEL);
 	if (!path)
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
-	kfree(filter->memcg_path);
+
+	mutex_lock(&damon_sysfs_lock);
+	old = filter->memcg_path;
 	filter->memcg_path = path;
+	mutex_unlock(&damon_sysfs_lock);
+
+	kfree(old);
 	return count;
 }
 
@@ -1196,15 +1201,20 @@ static ssize_t path_store(struct kobject *kobj,
 {
 	struct damos_sysfs_quota_goal *goal = container_of(kobj,
 			struct damos_sysfs_quota_goal, kobj);
-	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
-				   GFP_KERNEL);
+	char *path, *old;
 
+	path = kmalloc_array(size_add(count, 1), sizeof(*path), GFP_KERNEL);
 	if (!path)
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
-	kfree(goal->path);
+
+	mutex_lock(&damon_sysfs_lock);
+	old = goal->path;
 	goal->path = path;
+	mutex_unlock(&damon_sysfs_lock);
+
+	kfree(old);
 	return count;
 }
 
-- 
2.34.1

